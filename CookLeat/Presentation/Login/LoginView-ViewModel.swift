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
            let url = "http://127.0.0.1:8000/api/user/login"
            
            let dictionary: [String: Any] = [
                "name" : name,
                "password" : password
            ]
            
            NetworkHelper.shared.requestProvider(url: url, type: .POST, params: dictionary) { data, response, error in
                if let error = error {
                    self.onError(error: error.localizedDescription)
                } else if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let sessionToken = json["token"] as? String,
                                let user = json["user"] as? [String: Any],
                                let userId = user["id"] as? Int  {
                                // Save the session token to UserDefaults
                                UserDefaults.standard.set(sessionToken, forKey: "session_token")
                                UserDefaults.standard.set(userId, forKey: "user_id")
                                print("Session token: \(sessionToken), User ID: \(userId)")
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
                self.shouldShowHome = true
                }
        }
        
        func onError(error: String) {
            shouldShowErrorAlert = true
        }
        
    }
}

