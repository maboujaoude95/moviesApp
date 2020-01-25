//
//  Movie.swift
//  boostmi
//
//  Created by Mark Aboujaoude on 2020-01-20.
//  Copyright © 2020 Mark Aboujaoude. All rights reserved.
//

import Foundation

public struct Movie: Codable {

    let id: Int
    let title: String
    let overview: String?
    let releaseDate: Date
    let voteAverage: Double
    let voteCount: Int
    let adult: Bool
    let popularity: Float
    let posterPath: String?
    let backdropPath: String?
}
