//
//  LegoSetsApiMock.swift
//  brickheadzTests
//
//  Created by Anastasiia Gachkovskaya on 19/09/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import UIKit
@testable import brickheadz

final class LegoSetsApiMock: LegoSetsApiServiceProtocol {

    var fetchSetsWasCalled = false
    var mockedSetsResult: Result<[LegoSet], Error>!
    func fetchSets(completion: @escaping (Result<[LegoSet], Error>) -> Void) {
        completion(mockedSetsResult)
        fetchSetsWasCalled = true
    }

    var fetchImagesWasCalled = false
    var mockedFetchImageResult: UIImage!
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        completion(mockedFetchImageResult)
        fetchImagesWasCalled = true
    }
}
