//
//  LoginView-ViewModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 27/2/23.
//

import Foundation

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var shouldShowHome: Bool = false
        @Published var shouldShowErrorAlert: Bool = false
        

        func login(name: String, password: String) {
            
            let url = "http://127.0.0.1:8000/api/users/login"
            
            let dictionary: [String: Any] = [
                "name" : name,
                "password" : password
            ]
            
            NetworkHelper.shared.requestProvider(url: url, type: .POST, params: dictionary) { data, response, error in
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
                self.shouldShowHome = true
                }
        }
        
        func onError(error: String) {
            shouldShowErrorAlert = true
        }
        
    }
}
