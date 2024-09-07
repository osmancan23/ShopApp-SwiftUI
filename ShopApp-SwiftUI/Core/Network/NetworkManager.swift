//
//  NetworkManager.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import Foundation
import Alamofire

struct NetworkManager {

     func request <T:Codable>(onSuccess: @escaping (T) -> Void, onFailed: @escaping (String) -> Void, route: Route, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil) {
        let urlString = Route.baseUrl + route.value

        guard let url = urlString.asUrl else { return }


        AF.request(url, method: method, parameters: parameters, headers: headers).responseDecodable(of: T.self) { result in

            guard let value = result.value else {
                print(result.response)
                print(result.request)
                onFailed(result.error!.localizedDescription)
                return
            }

            onSuccess(value)

        }
    }
}
