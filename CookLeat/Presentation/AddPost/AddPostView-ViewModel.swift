//
//  AddPostView-ViewModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 1/3/23.
//

import Foundation

extension AddPostView {
    class ViewModel: ObservableObject {
        @Published var shouldPost: Bool = false
        @Published var shouldShowErrorAlert: Bool = false
        

        func addPost(name: String,description: String, user: Int,category: Int, image: String) {
            
            let url = "http://127.0.0.1:8000/api/recipe/create"
            
            let dictionary: [String: Any] = [
                "name" : name,
                "description" : description,
                "user" : user,
                "category": category,
                "image": image
            ]
            
            NetworkHelper.shared.requestProvider(url: url, type: .PUT, params: dictionary) { data, response, error in
                if let error = error {
                    self.onError(error: error.localizedDescription)
                } else if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        self.onSuccess()
                    } else {
                        self.onError(error: error?.localizedDescription ?? "Request Error")
                    }
                }
            }
        }
        
        func onSuccess() {
            DispatchQueue.main.async {
                self.shouldPost = true
                }
        }
        
        func onError(error: String) {
            shouldShowErrorAlert = true
        }
        
    }
}
