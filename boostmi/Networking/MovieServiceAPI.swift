//
//  MovieServiceAPI.swift
//  boostmi
//
//  Created by Mark Aboujaoude on 2020-01-20.
//  Copyright © 2020 Mark Aboujaoude. All rights reserved.
//

import Foundation

class MovieServiceAPI {

    public static let shared = MovieServiceAPI()
    private init() {}
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    private let apiKey = "6c52966d9be717e486a2a0c499867009"
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()

    enum Endpoint: String, CaseIterable {
        case nowPlaying = "now_playing"
        case upcoming
        case popular
        case topRated = "top_rated"
    }

    public enum APIServiceError: Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }

    public func fetchMovies(from endpoint: Endpoint, result: @escaping (Result<MoviesResponse, APIServiceError>) -> Void) {
        let movieURL = baseURL
            .appendingPathComponent("movie")
            .appendingPathComponent(endpoint.rawValue)
        fetchResources(url: movieURL, completion: result)
    }

    private func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }

        urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            guard let urlResponse = response as? HTTPURLResponse,
                let responseData = data,
                let object = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments),
                let jsonValues = object as? [String: Any] else {
                    return
            }

            switch Http.StatusCode.getGeneric(value: urlResponse.statusCode) {
            case .succeeded:
                do {
                    let values = try self?.jsonDecoder.decode(T.self, from: responseData)
                    completion(.success(values!))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .unauthorized:
                completion(.failure(.apiError))
            default: break
            }
        }.resume()
    }
}