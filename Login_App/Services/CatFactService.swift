//
//  CatFactService.swift
//  Login_App
//
//  Created by Henadzi on 18/12/2022.
//

import Foundation
import Alamofire

final public class CatFactService {
    
    private let getFactURL = "https://catfact.ninja/fact"
    private let getFactsURL = "https://catfact.ninja/facts"
    
    // Вариант через Alamofire
    func getFactAlamofireRequest(_ completion: @escaping (CatFact?) -> Void) {
        AF.request(getFactURL).responseDecodable(of: CatFact.self) { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print("Get fact error \(error)")
                completion(nil)
            }
        }
    }
    
    func getFactsAlamofireRequest() {
        AF.request(getFactsURL).responseDecodable(of: CatFacts.self) { response in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print("Get fact error \(error)")
            }
        }
    }
    
    // Вариант через нативный URLSession
    func getFact(_ completion: @escaping (Result<CatFact, Error>) -> Void) {
        NetworkService.request(getFactURL) { data, error in
            do {
                if let data {
                    let factData = try JSONDecoder().decode(CatFact.self, from: data)
                    completion(.success(factData))
                } else if let error {
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getFacts(_ completion: @escaping (Result<CatFacts, Error>) -> Void) {
        NetworkService.request(getFactsURL) { data, error in
            do {
                if let data {
                    let factsData = try JSONDecoder().decode(CatFacts.self, from: data)
                    completion(.success(factsData))
                } else if let error {
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
