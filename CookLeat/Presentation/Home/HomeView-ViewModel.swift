//
//  HomeView-ViewModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 3/3/23.
//

import Foundation

//MARK: LikePresentationModel
struct LikePresentationModel: Identifiable {
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
    
    init(dataModel: LikedDataModel?) {
        self.name = dataModel?.name ?? ""
        self.image = dataModel?.image ?? ""
        self.description = dataModel?.description ?? ""
        self.user = dataModel?.user ?? ""
        self.userPic = dataModel?.userPic ?? ""
        self.category = dataModel?.category ?? "Carne"
    }
}
//MARK: RecentPresentationModel
struct RecentPresentationModel: Identifiable {
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
    
    init(dataModel: RecipeDataModel?) {
        self.name = dataModel?.name ?? ""
        self.image = dataModel?.image ?? ""
        self.description = dataModel?.description ?? ""
        self.user = dataModel?.user ?? ""
        self.userPic = dataModel?.userPic ?? ""
        self.category = dataModel?.category ?? "Carne"
    }
}

extension HomeView{
    
    class ViewModel: ObservableObject{
        @Published var recents: [RecentPresentationModel] = []
        @Published var liked: [LikePresentationModel] = []
        
        func getRecent(){
            
            NetworkHelper.shared.requestProvider(url: "http://127.0.0.1:8000/api/recipe/recent", type: .GET) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    
                }else if let data = data, let response = response as? HTTPURLResponse{
                    print(response.statusCode)
                    //print(String(bytes:data, encoding: .utf8))
                    if response.statusCode == 200{
                        do {
                            let recipeDataModel = try  JSONDecoder().decode(RecipeRecentDataModel.self, from: data)
                            // access the user properties as needed
                            //print(recipeDataModel)
                            
                            self.recents = recipeDataModel.recent.compactMap({ recipe in
                                return RecentPresentationModel(dataModel: recipe)
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
        
        func getLiked(){
            
            NetworkHelper.shared.requestProvider(url: "http://127.0.0.1:8000/api/recipe/favorite/\(UserDefaults.standard.integer(forKey: "user_id"))", type: .GET) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    
                }else if let data = data, let response = response as? HTTPURLResponse{
                    print(response.statusCode)
                    //print(String(bytes:data, encoding: .utf8))
                    if response.statusCode == 200{
                        do {
                            let likedRecipeDataModel = try  JSONDecoder().decode(LikedRecipeDataModel.self, from: data)
                            // access the user properties as needed
                            //print(recipeDataModel)
                            
                            self.liked = likedRecipeDataModel.favorites.compactMap({ recipe in
                                return LikePresentationModel(dataModel: recipe)
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
