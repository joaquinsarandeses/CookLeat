//
//  UserData.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 1/3/23.
//

import Foundation

struct UserData: Codable {
    let id: Int
    let name: String
    let email: String
    let profPic: String
}

class UserDataManager {
    static let shared = UserDataManager()
    
    private init() {}
    
    func getUserData(sessionToken: String, completion: @escaping (Result<UserData, Error>) -> Void) {
        let url = URL(string: "http://127.0.0.1:8000/api/user")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(sessionToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let userData = try JSONDecoder().decode(UserData.self, from: data)
                    print(userData.self)
                    completion(.success(userData))
                    
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
}

