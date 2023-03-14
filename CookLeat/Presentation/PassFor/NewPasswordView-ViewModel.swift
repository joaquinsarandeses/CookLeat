//
//  NewPasswordView-ViewModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 12/3/23.
//

import Foundation

extension NewPasswordView{
    class ViewModel: ObservableObject{
        
        func recoverPassword(email: String) {
            
            let url = "http://127.0.0.1:8000/api/password/recover"
            
            let dictionary: [String: Any] = [
                "email" : email
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
                
                }
        }
        
        func onError(error: String) {

        }
        
    }
}
