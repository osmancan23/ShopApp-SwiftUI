//
//  NetworkManager.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    func request<T: Codable>(route: Route, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil) async throws -> T {
        let urlString = Route.baseUrl + route.value
        
        guard let url = urlString.asUrl else {
            throw NetworkError.invalidURL
        }
        
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: method, parameters: parameters, headers: headers)
                .validate()
                .responseData { response in
                    
                    if let data = response.data {
                        
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let decodedResponse = try decoder.decode(T.self, from: data)
                            continuation.resume(returning: decodedResponse)
                        } catch {
                            continuation.resume(throwing: NetworkError.decodingError(error.localizedDescription))
                        }
                    } else if let error = response.error {
                        continuation.resume(throwing: NetworkError.networkError(error.localizedDescription))
                    } else {
                        continuation.resume(throwing: NetworkError.unknownError)
                    }
                }
        }
    }
}

enum NetworkError: LocalizedError {
    case invalidURL
    case decodingError(String)
    case networkError(String)
    case apiError(message: String)
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Geçersiz URL"
        case .decodingError(let message):
            return "Veri çözümleme hatası: \(message)"
        case .networkError(let message):
            return "Ağ hatası: \(message)"
        case .apiError(let message):
            return "API hatası: \(message)"
        case .unknownError:
            return "Bilinmeyen bir hata oluştu"
        }
    }
}

struct ErrorResponse: Codable {
    let message: String
}
