//
//  TVResponde.swift
//  SwiftNetworking
//
//  Created by Erik Valencia Cardona on 9/10/26.
//

import Foundation

struct TVResponse: Decodable {
    let page: Int
    let results: [TVSeries]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


