//
//  UserData.swift
//  Login_App
//
//  Created by Padabed Nikita on 13/02/2023.
//

import Foundation

struct UserData: Codable {
    let id: Int
    let name: String
    let address: UserAddress
    let company: UserCompany
}

struct UserAddress: Codable {
    let street: String
    let city: String
}

struct UserCompany: Codable {
    let name: String
    let slogan: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case slogan = "catchPhrase"
    }
}




