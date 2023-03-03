//
//  RegisterView-ViewModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 28/2/23.
//

import Foundation

extension RegisterView {
    class ViewModel: ObservableObject {
        @Published var shouldShowHome: Bool = false
        @Published var shouldShowErrorAlert: Bool = false
        

        func register(name: String,email: String, password: String) {
            
            let url = "http://127.0.0.1:8000/api/user/registro"
            
            let dictionary: [String: Any] = [
                "name" : name,
                "email" : email,
                "password" : password
            ]
            
            NetworkHelper.shared.requestProvider(url: url, type: .PUT, params: dictionary) { data, response, error in
                if let error = error {
                    self.onError(error: error.localizedDescription)
                } else if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let sessionToken = json["session_token"] as? String {
                                                   // Save the session token to UserDefaults
                                UserDefaults.standard.set(sessionToken, forKey: "session_token")
                       
                                                   // Show the home screen
                                self.onSuccess()
                        } else {
                                self.onError(error: "Invalid server response")
                        }
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
