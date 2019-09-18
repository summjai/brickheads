//
//  LegoSetApiContainer.swift
//  brickheadz
//
//  Created by Anastasiia Gachkovskaya on 18/09/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import Foundation

struct LegoSetApiContainer: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [LegoSet]
}
