//
//  MoviesResponse.swift
//  boostmi
//
//  Created by Mark Aboujaoude on 2020-01-20.
//  Copyright © 2020 Mark Aboujaoude. All rights reserved.
//

import Foundation

public struct MoviesResponse: Codable {

    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
}
