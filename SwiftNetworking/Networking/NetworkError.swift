//
//  NetworkError.swift
//  SwiftNetworking
//
//  Created by Erik Valencia Cardona on 9/10/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case noData
    case decodingError(Error)
    case requestFailed(Error)
}
