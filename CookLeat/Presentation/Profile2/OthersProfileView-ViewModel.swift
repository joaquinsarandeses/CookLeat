//
//  OthersProfileView-ViewModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 7/3/23.
//

import Foundation

struct OthersEventsPresentationModel: Identifiable {
    var uuid = UUID()
    var id: Int
    var name: String
    var image: String
    var description: String
    var user: String
    var profilePic: String
    var category: String
    
    init() {
        self.id = 1
        self.name = ""
        self.image = ""
        self.description = ""
        self.user = ""
        self.profilePic = ""
        self.category = ""
    }
    
    init(dataModel: UsersRecipeDataModel?) {
        self.id = dataModel?.id ?? 1
        self.name = dataModel?.name ?? " "
        self.image = dataModel?.image ?? " "
        self.description = dataModel?.description ?? " "
        self.user = dataModel?.user ?? " "
        self.profilePic = dataModel?.profilePic ?? " "
        self.category = dataModel?.category ?? "Carne"
    }
}


extension OthersProfileView{
    struct UserPresentationModel: Identifiable {
        var uuid = UUID()
        var id: Int
        var name: String
        var image: String
        var followers: Int
        var follows: Int
        
        init() {
            self.id = 1
            self.name = ""
            self.image = ""
            self.followers = 0
            self.follows = 0
        }
        
        init(dataModel: UserDataModel) {
            self.id = dataModel.id ?? 1
            self.name = dataModel.name ?? ""
            self.image = dataModel.image ?? ""
            self.followers = dataModel.followers ?? 0
            self.follows = dataModel.follows ?? 0
        }
    }
    class ViewModel: ObservableObject{
        var id: Int
        var name: String
        var image: String
        var followers : Int
        var follows: Int
        
        @Published var otherProfile: UserPresentationModel = .init()
        @Published var othersEvents: [OthersEventsPresentationModel] = []
        init() {
            self.id = 1
            self.name = ""
            self.image = ""
            self.follows = 1
            self.followers = 1
        }
        
        init(followed: FollowedPresentationModel) {
            self.id = followed.id
            self.name = followed.name
            self.image = followed.image
            self.follows = followed.follows
            self.followers = followed.followers
        }
        
        init(follows: FollowsPresentationModel) {
            self.id = follows.id
            self.name = follows.name
            self.image = follows.image
            self.follows = follows.follows
            self.followers = follows.followers
        }
        
        
        
        func getOtherEvents(){
            print(otherProfile.id)
            NetworkHelper.shared.requestProvider(url: "https://4345-77-230-119-36.ngrok-free.app/api/user/userRecipes/\(id)", type: .GET) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    
                }else if let data = data, let response = response as? HTTPURLResponse{
                    print(response.statusCode)
                    //print(String(bytes:data, encoding: .utf8))
                    if response.statusCode == 200{
                        do {
                            let otherRecipeDataModel = try  JSONDecoder().decode(MyRecipeDataModel.self, from: data)
                            // access the user properties as needed
                            //print("La receta se muestra \(myRecipeDataModel)")
                            
                            self.othersEvents = otherRecipeDataModel.userRecipes.compactMap({ recipe in
                                return OthersEventsPresentationModel(dataModel: recipe)
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
    
        }

    }
}
