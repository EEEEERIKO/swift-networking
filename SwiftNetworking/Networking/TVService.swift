//
//  TVService.swift
//  SwiftNetworking
//
//  Created by Erik Valencia Cardona on 9/10/26.
//

import Foundation

final class TVService {
    
    private let baseURL = "https://api.themoviedb.org/3/tv"
    private let apiKey = "7481bbcf1fcb56bd957cfe9af78205f3"
    
    func fetchTopRatedTVShows(
    completion: @escaping (Result<[TVSeries], NetworkError>)
    -> Void ){
        var components = URLComponents(
            string: "\(baseURL)/top_rated"
        )
        
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "langauge", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
        
        guard let url = components?.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(
                    .failure(.httpError(statusCode: response.statusCode))
                )
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(TVResponse.self, from: data)
                    completion(.success(result.results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }.resume()
    }
}
