//
//  FollowedView-ViewModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 5/3/23.
//

import Foundation

struct FollowedPresentationModel: Identifiable {
    var uuid = UUID()
    var id: Int
    var name: String
    var image: String
    var follows: Int
    var followers: Int

    
    init() {
        self.id = 1
        self.name = ""
        self.image = ""
        self.followers = 1
        self.follows = 1
        
    }
    
    init(dataModel: FollowedDataModel?) {
        self.id = dataModel?.id ?? 1
        self.name = dataModel?.name ?? ""
        self.image = dataModel?.image ?? ""
        self.follows = dataModel?.followed_count ?? 1
        self.followers = dataModel?.follower_count ?? 1
    }
}

extension FollowedView{
    
    
    class ViewModel: ObservableObject{
        @Published var followed: [FollowedPresentationModel] = []
        func getFollowed(){
            
            NetworkHelper.shared.requestProvider(url: "http://127.0.0.1:8000/api/follow/list/seguidos/\(UserDefaults.standard.integer(forKey: "user_id"))", type: .GET) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    
                }else if let data = data, let response = response as? HTTPURLResponse{
                    print(response.statusCode)
                    print(String(bytes:data, encoding: .utf8))
                    if response.statusCode == 200{
                        do {
                            let followedDataModel = try  JSONDecoder().decode(FolowedListDataModel.self, from: data)
                            // access the user properties as needed
                            print("\(followedDataModel)")
                            self.followed = followedDataModel.followers.compactMap({ followed in
                                return FollowedPresentationModel(dataModel: followed)
                            })
                            print("")
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                    }else{
                        self.onError(error: error?.localizedDescription ?? "Request error")
                        
                    }
                }
            }
        }
        
        func onSucces(data:Data){
        }

        func onError(error: String){
            
        }
        
    }
}
