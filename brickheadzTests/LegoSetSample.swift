//
//  LegoSetSample.swift
//  brickheadzTests
//
//  Created by Anastasiia Gachkovskaya on 19/09/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import Foundation
@testable import brickheadz

extension LegoSet {
    static func sample(
        serialNumber: String = "asdasd-12dad",
        name: String = "Lego City",
        year: Int = 1995,
        pieces: Int = 204,
        imageUrl: URL? = nil
    ) -> LegoSet {
        return LegoSet(
            serialNumber: serialNumber,
            name: name,
            year: year,
            pieces: pieces,
            imageUrl: imageUrl
        )
    }
}
