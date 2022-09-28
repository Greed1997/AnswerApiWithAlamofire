//
//  NetworkManager.swift
//  YesOrNo
//
//  Created by Александр on 28.09.2022.
//

import Foundation
import Alamofire

let linkAPI = "https://yesno.wtf/api"
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
enum DataResponse {
    case decodable(Any)
    case afError(AFError)
}
class NetworkManager {
    
    func fetchData(_ url: String, completion: @escaping (Result<Answer, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        AF.request(url)
            .validate()
            .responseDecodable(of: Answer.self) { DataResponse in
                switch DataResponse.result {
                case .success(let value):
                    let answer = Answer.getAnswer(from: value)
                    DispatchQueue.main.async {
                        completion(.success(answer))
                    }
                case .failure(_):
                    completion(.failure(.decodingError))
                }
            }
    }
    static let shared = NetworkManager()
    
    private init() {}
}
