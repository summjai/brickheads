//
//  LegoSet.swift
//  brickheadz
//
//  Created by Anastasiia Gachkovskaya on 18/09/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import Foundation

struct LegoSet: Decodable {

    enum CodingKeys: String, CodingKey {
        case serialNumber = "set_num"
        case name
        case year
        case pieces = "num_parts"
        case imageUrl = "set_img_url"
    }

    let serialNumber: String
    let name: String
    let year: Int
    let pieces: Int
    let imageUrl: URL?
}
