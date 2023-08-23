//
//  NetworkClient.swift
//  CoinAppSwiftUI
//
//  Created by cem on 23.08.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct NetworkClient {
    private let baseURL: String
    private let headers: [String: String]?

    static let shared = NetworkClient()

    private init() {
        self.baseURL = ApiConstants.baseUrl
        self.headers = nil
    }

    func performRequest(path: String, method: HTTPMethod, queryParameters: [String: String]? = nil) async throws -> (Data, URLResponse) {
        var urlComponents = URLComponents(string: baseURL.appending(path))

        if let queryParameters = queryParameters {
            urlComponents?.queryItems = queryParameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }

        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        return (data, response)
    }
}
