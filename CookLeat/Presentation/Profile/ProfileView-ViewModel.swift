//
//  ProfileView-ViewModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 1/3/23.
//

import Foundation

extension ProfileView {
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
    
    class ViewModel: ObservableObject {
        @Published var shouldUpdate: Bool = false
        @Published var shouldShowErrorAlert: Bool = false
        
        @Published var profile: UserPresentationModel = .init()
        
        func getProfileData() {
            let url = "http://127.0.0.1:8000/api/user/show/\(UserDefaults.standard.integer(forKey: "user_id"))"
            
            NetworkHelper.shared.requestProvider(url: url , type: .GET) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data, let response = response as? HTTPURLResponse {
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
        
        func onSuccess() {
            DispatchQueue.main.async {
                self.shouldUpdate = true
                }
        }
        
        func onError(error: String) {
            shouldShowErrorAlert = true
        }
    }
}
