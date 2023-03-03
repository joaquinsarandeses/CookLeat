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
        
        func onError(error: String){
            
        }
    }
    
    //    class ViewModel: ObservableObject {
    //        @Published var userData: UserData?
    //        var userId: Int
    //
    //        init() {
    //               self.userId = UserDefaults.standard.integer(forKey: "UserId")
    //           }
    //
    //        func getUserData() {
    //            let url = URL(string: "https://example.com/api/users/\(userId)")! // replace with your API endpoint
    //            var request = URLRequest(url: url)
    //
    //            request.httpMethod = "GET"
    //
    //            URLSession.shared.dataTask(with: request) { data, response, error in
    //                if let error = error {
    //                    print(error)
    //                }
    //
    //                guard let data = data else {
    //                    print("No data received")
    //                    return
    //                }
    //
    //                if let userData = try? JSONDecoder().decode(UserData.self, from: data) {
    //                    DispatchQueue.main.async {
    //                        self.userData = userData
    //                    }
    //                } else {
    //                    print("Error decoding user data")
    //                }
    //            }.resume()
    //        }
    //
    //
    //        func getEvents(){
    //
    //            NetworkHelper.shared.requestProvider(url: "https://example.com/api/users/\(userId)", type: .GET) { data, response, error in
    //                if let error = error {
    //                    print(error.localizedDescription)
    //
    //                }else if let data = data, let response = response as? HTTPURLResponse{
    //                    print(response.statusCode)
    //                    print(String(bytes:data, encoding: .utf8))
    //                    if response.statusCode == 200{
    //                        onSucces(data: data)
    //
    //                    }else{
    //                        onError(error: error?.localizedDescription ?? "Request error")
    //
    //                    }
    //                }
    //            }
    //        }
    //
    //        func onSucces(data: Data){
    //            do{
    //                let eventsNotFiltered = try JSONDecoder().decode([EventResponseModel?].self, from: data)
    //                events = eventsNotFiltered.compactMap({ eventNotFiltered in
    //                    guard let date = eventNotFiltered?.date else { return nil }
    //                    return UserPresentationModel(name: eventNotFiltered?.name ?? "", date: date)
    //                })
    //            }catch{
    //                self.onError(error: error.localizedDescription)
    //            }
    //        }
    //        func onError(error: String){
    //
    //        }
    //    }
}
