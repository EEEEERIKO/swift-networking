//
//  TVSeries.swift
//  SwiftNetworking
//
//  Created by Erik Valencia Cardona on 9/10/26.
//
import Foundation

struct TVSeries: Decodable {
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
    }
}
