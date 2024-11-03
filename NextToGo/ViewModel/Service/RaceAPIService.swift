//
//  RaceAPIService.swift
//  NextToGo
//
//  Created by Henry Liu on 2/11/2024.
//

import Foundation
import Combine

protocol RaceAPIServiceProtocol {
    func fetchRaces() -> AnyPublisher<APIResponse, Error>
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
}

struct RaceAPIService: RaceAPIServiceProtocol {
    func fetchRaces() -> AnyPublisher<APIResponse, Error> {
        guard let url = URL(string: "https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=5") else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
