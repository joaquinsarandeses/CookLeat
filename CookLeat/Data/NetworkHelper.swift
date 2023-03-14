//
//  NetworkHelper.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 27/2/23.
//

import Foundation

class NetworkHelper {
    
    //MARK: - Enum
    enum RequestType: String {
        case POST
        case GET
        case PUT
    }
    // MARK: - Constants
    static let shared = NetworkHelper()
    
    // MARK: - Private Methods
    private func requestApi(request: URLRequest, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            completion(data, response, error)
        }

        task.resume()
    }
    
    //MARK: - Public Methods
    
    func requestProvider(url: String, type: RequestType, params: [String: Any]? = nil, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) -> Void {
        
        let url = URL(string: url)
        
        guard let urlNotNil = url else { return }
        
        var request = URLRequest(url: urlNotNil)
        
        request.httpMethod = type.rawValue
        
        if let dictionary = params {
            let data = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
            request.httpBody = data
        }
        
        //añadimos los headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //llamamos a la función requestApi
        requestApi(request: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }
    }
    
}
