//
//  SearchView-ViewModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 6/3/23.
//

import Foundation
struct AllPresentationModel: Identifiable {
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
    
    init(dataModel: AllRecipeDataModel?) {
        self.name = dataModel?.name ?? ""
        self.image = dataModel?.image ?? ""
        self.description = dataModel?.description ?? ""
        self.user = dataModel?.user ?? ""
        self.userPic = dataModel?.profilePicture ?? ""
        self.category = dataModel?.category ?? "Carne"
    }
}
extension SearchView{

    class ViewModel: ObservableObject{
        @Published var all: [AllPresentationModel] = []
        
        
        func getAll(){
            
            NetworkHelper.shared.requestProvider(url: "https://4345-77-230-119-36.ngrok-free.app/api/recipe/list", type: .GET) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    
                }else if let data = data, let response = response as? HTTPURLResponse{
                    print(response.statusCode)
                    print(String(bytes:data, encoding: .utf8))
                    if response.statusCode == 200{
                        do {
                            let allDataModel = try  JSONDecoder().decode(AllDataModel.self, from: data)
                            // access the user properties as needed
                            print(allDataModel)
                            
                            self.all = allDataModel.list.compactMap({ recipe in
                                return AllPresentationModel(dataModel: recipe)
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
        func onError(error: String){
            
        }
    }
    

   
}
