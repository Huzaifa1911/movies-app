//
//  NetworkEndpoint.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 02/02/2024.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var host: String { get }
    var accessToken: String { get }
    var httpMethod: RequestMethod { get }
    var httpHeaders: [String: String] { get }
    var useToken: Bool { get }
    var params: [String: String] { get }
    var body: [String: Any] { get }
}

extension Endpoint {
    var httpHeaders: [String: String] { [:] }
    var useToken: Bool { accessToken.isEmpty.inverted } // if accessToken is not provided no need to attach the header
    var params: [String: String] { [:] }
    var body: [String: Any] { [:] }

    func createRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        // setting queryParams if provided.
        if params.isEmpty.inverted {
            urlComponents.queryItems = params.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        
        guard let url = urlComponents.url else { throw URLError(.badURL) }
        print("Calling Endpoint: \(url)")
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = httpMethod.rawValue
        httpRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if useToken {
            httpRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        // attaching additional headers if provided
        if httpHeaders.isEmpty.inverted {
            httpRequest.allHTTPHeaderFields = httpHeaders
        }
        
        // attaching body if provided
        if body.isEmpty.inverted {
            httpRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        return httpRequest
    }
}
