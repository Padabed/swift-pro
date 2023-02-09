//
//  CatFactData.swift
//  Login_App
//
//  Created by Henadzi on 19/01/2023.
//

import Foundation

struct CatFacts: Codable {
    let current_page: Int?
    let data: [CatFact]
}

struct CatFact: Codable {
    let fact: String
    let factCharCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case fact
        case factCharCount = "length"
    }
}
