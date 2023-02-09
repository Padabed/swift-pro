//
//  NetworkService.swift
//  Login_App
//
//  Created by Henadzi on 18/12/2022.
//

import Foundation

public enum NetworkError: String, Error {
    case missingURL = "URL is nil"
    case failRequest = "Request failed"
}

final public class NetworkService {
    static func request(_ urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard
            let url = URL(string: urlString)
        else {
            completion(nil, NetworkError.missingURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { completion($0, $2) })
        task.resume()
    }
}
