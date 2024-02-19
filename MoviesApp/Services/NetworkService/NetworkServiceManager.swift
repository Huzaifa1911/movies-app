//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 02/02/2024.
//

import Foundation

protocol NetworkServiceManagerProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

class NetworkServiceManager: NetworkServiceManagerProtocol {
    private let urlSession: URLSession
    private let jsonDecode: JSONDecoder
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
        self.jsonDecode = JSONDecoder()
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let (data, response) = try await urlSession.data(for: endpoint.createRequest())
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.responseUnsuccessful }
        switch httpResponse.statusCode {
        case 200...299:
            return try parser(data)
        case 400...499:
            throw NetworkError.notFound
        case 500...599:
            throw NetworkError.badRequest
        default:
            throw NetworkError.unknownError
        }
    }
    
    private func parser<T: Decodable>(_ data: Data) throws -> T {
        try jsonDecode.decode(T.self, from: data)
    }
}
