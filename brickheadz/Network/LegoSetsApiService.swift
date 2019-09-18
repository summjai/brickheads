//
//  LegoSetsApiService.swift
//  brickheadz
//
//  Created by Anastasiia Gachkovskaya on 18/09/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import Foundation

protocol LegoSetsApiServiceProtocol {
    func fetchSets(completion: @escaping (Result<[LegoSet], Error>) -> Void)
}

final class LegoSetsApiService: LegoSetsApiServiceProtocol {

    // MARK: - Private Properties

    private let networkClient = NetworkClient()
    // I know that this key shouldn't be commited to a repo and should be
    // stored in .env file for example, but in this case it wouldn't be possible to test the app
    private let key = "262a544a78e1cbca7f70541ce6e6bc2c"

    // MARK: - Public Methods

    func fetchSets(completion: @escaping (Result<[LegoSet], Error>) -> Void) {
        var request = URLRequest(
            url: URL(string: "https://rebrickable.com/api/v3/lego/sets/")!
        )
        request.setValue("key \(key)", forHTTPHeaderField: "Authorization")
        networkClient.fetchRequest(request) { (result: Result<LegoSetApiContainer, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let container):
                    completion(.success(container.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
