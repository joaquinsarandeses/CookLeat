//
//  ProfileView-ViewModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 1/3/23.
//

import Foundation

struct MyEventsPresentationModel: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var description: String
    var user: String
    var userPic: String
    var category: String
    
    init() {
        self.name = ""
        self.image = ""
        self.description = ""
        self.user = ""
        self.userPic = ""
        self.category = ""
    }
    
    init(dataModel: UsersRecipeDataModel?) {
        self.name = dataModel?.name ?? " "
        self.image = dataModel?.image ?? " "
        self.description = dataModel?.description ?? " "
        self.user = dataModel?.user ?? " "
        self.userPic = dataModel?.userPic ?? " "
        self.category = dataModel?.category ?? "Carne"
    }
}

extension ProfileView {
    //MARK: user presentation model
    struct UserPresentationModel: Identifiable {
        var id = UUID()
        var name: String
        var image: String
        var followers: Int
        var follows: Int
        
        init() {
            self.name = ""
            self.image = ""
            self.followers = 0
            self.follows = 0
        }
        
        init(dataModel: UserDataModel) {
            self.name = dataModel.name ?? ""
            self.image = dataModel.image ?? ""
            self.followers = dataModel.followers ?? 0
            self.follows = dataModel.follows ?? 0
        }
    }
    //MARK: Events presentationModel
   
    
    class ViewModel: ObservableObject {
        @Published var shouldUpdate: Bool = false
        @Published var shouldShowErrorAlert: Bool = false
        
        @Published var profile: UserPresentationModel = .init()
        @Published var myEvents: [MyEventsPresentationModel] = []
        
        
        
        
        //MARK: Recibir los datos del usuario
        func getProfileData() {
            let url = "http://127.0.0.1:8000/api/user/show/\(UserDefaults.standard.integer(forKey: "user_id"))"
            
            NetworkHelper.shared.requestProvider(url: url , type: .GET) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data, let response = response as? HTTPURLResponse {
                    print(String(bytes:data, encoding: .utf8))
                    print(response.statusCode)
                    if response.statusCode == 200 {
                        do {
                            let userDataModel = try  JSONDecoder().decode(UserDataModel.self, from: data)
                            // access the user properties as needed
                            print(userDataModel.name)
                            
                            self.profile = UserPresentationModel(dataModel: userDataModel)
                        } catch {
                            print(error.localizedDescription)
                        }
                    } else {
                        self.onError(error: error?.localizedDescription ?? "Request error")
                    }
                }
            }
        }
        //MARK: Cambiar la foto de perfil
        func changePic(id: Int, image: String) {
            let url = "http://127.0.0.1:8000/api/user/update"
            
            let dictionary: [String: Any] = [
                "id" : id,
                "image" : image
            ]
            
            NetworkHelper.shared.requestProvider(url: url, type: .POST, params: dictionary) { data, response, error in
                if let error = error {
                    self.onError(error: error.localizedDescription)
                } else if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        do {
                            if try JSONSerialization.jsonObject(with: data, options: []) is [String: Any]
                            {
                                // Save the session token to UserDefaults
                                // Show the home screen
                                self.onSuccess()
                            } else {
                                self.onError(error: "Invalid server response")
                            }
                        } catch {
                            self.onError(error: error.localizedDescription)
                        }
                    } else {
                        self.onError(error: error?.localizedDescription ?? "Request Error")
                    }
                }
            }
        }
        //MARK: Recibir losn posts del usuario
        func getMyEvents(){
            
            NetworkHelper.shared.requestProvider(url: "http://127.0.0.1:8000/api/user/userRecipes/\(UserDefaults.standard.integer(forKey: "user_id"))", type: .GET) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    
                }else if let data = data, let response = response as? HTTPURLResponse{
                    print(response.statusCode)
                    //print(String(bytes:data, encoding: .utf8))
                    if response.statusCode == 200{
                        do {
                            let myRecipeDataModel = try  JSONDecoder().decode(MyRecipeDataModel.self, from: data)
                            // access the user properties as needed
                            //print("La receta se muestra \(myRecipeDataModel)")
                            
                            self.myEvents = myRecipeDataModel.userRecipes.compactMap({ recipe in
                                return MyEventsPresentationModel(dataModel: recipe)
                            })
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                    }else{
                        self.onError(error: error?.localizedDescription ?? "Request error")
                        
                    }
                }
            }
        }
        
        func onSuccess() {
            DispatchQueue.main.async {
                
                }
        }
        
        func onError(error: String) {
            shouldShowErrorAlert = true
        }
    }
}
