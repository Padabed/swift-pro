//
//  UserService.swift
//  Login_App
//
//  Created by Padabed Nikita on 13/02/2023.
//

import Foundation
import Alamofire

class UserService {
    
    private let userDataURL = "https://jsonplaceholder.typicode.com/users"
    
    func getUsersData(_ completion: @escaping ([UserData]) -> Void) {
        AF.request(userDataURL).responseDecodable(of: [UserData].self) { response in
            switch response.result {
            case .success(let userData):
                completion(userData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
}
