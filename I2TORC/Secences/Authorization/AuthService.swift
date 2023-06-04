//
//  AuthService.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/4/23.
//

import Foundation

class AuthService {
    static func registerUser(userName: String, email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://your-api-endpoint/register") else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "userName": userName,
            "email": email,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check the HTTP status code and handle the response from the server as needed
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    completion(.success(()))
                } else {
                    let error = NSError(domain: "Registration Failed", code: httpResponse.statusCode, userInfo: nil)
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

