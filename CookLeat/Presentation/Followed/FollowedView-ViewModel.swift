//
//  FollowedView-ViewModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 5/3/23.
//

import Foundation

extension FollowedView{
    struct FollowedPresentationModel: Identifiable {
        var id = UUID()
        var name: String
        var image: String
        
        init() {
            self.name = ""
            self.image = ""

        }
        
        init(dataModel: FollowedDataModel?) {
            self.name = dataModel?.name ?? ""
            self.image = dataModel?.image ?? ""
        }
    }
    
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
                            //print(recipeDataModel)
                            print("\(followedDataModel)")
                            self.followed = followedDataModel.followers.compactMap({ followed in
                                return FollowedPresentationModel(dataModel: followed)
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
        
        func onSucces(data:Data){
        }

        func onError(error: String){
            
        }
        
    }
}
