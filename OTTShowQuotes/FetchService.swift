//
//  FetchService.swift
//  OTTShowQuotes
//
//  Created by Ishaan Das on 14/06/24.
//

import Foundation

struct FetchService {
    private enum FetchError: Error {
        case badResponse
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
//    https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    func fetchQuote(from show: String) async throws -> Quote {
        //Build Fetch URl
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Deal with respone
        guard let response = response as? HTTPURLResponse, response.statusCode == 200
        else{
            throw FetchError.badResponse
        }
        
        //Decode
        let quote = try JSONDecoder().decode(Quote.self, from:data)
        
        //return quote
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Character {
        let characterURL = baseURL.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200
        else{
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data)
        // [Character].self because of how API is returning it
        return characters[0]
    }
    
    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200
        else{
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        for death in deaths {
            if death.character == character{
                return death
            }
        }
        return nil
    }
}
