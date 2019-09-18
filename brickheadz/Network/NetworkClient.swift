//
//  NetworkClient.swift
//  brickheadz
//
//  Created by Anastasiia Gachkovskaya on 18/09/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import Foundation

final class NetworkClient {
    func fetchRequest<T: Decodable>(
        _ request: URLRequest,
        completion: @escaping (Result<T,Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    let model = try JSONDecoder().decode(
                        T.self,
                        from: data
                    )
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }
            }.resume()
    }

    func fetchImage(
        _ request: URLRequest,
        completion: @escaping (Data?) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil)
                return
            }

            if let data = data {
                completion(data)
            }
        }.resume()
    }
}
