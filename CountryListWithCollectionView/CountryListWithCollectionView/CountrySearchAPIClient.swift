//
//  CountrySearchAPIClient.swift
//  CountryListWithCollectionView
//
//  Created by Yuliia Engman on 1/14/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import Foundation
import NetworkHelper

struct CountrySearchAPIClient {
    static func fetchCountry(for searchQuery: String, completion: @escaping(Result<[Country], AppError>) -> ()) {
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "uk"
        
        let countryEndpointURL = "https://restcountries.eu/rest/v2/name/\(searchQuery)"
        
        guard let url = URL(string: countryEndpointURL) else {
        completion(.failure(.badURL(countryEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) {(result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode([Country].self, from: data)
                    
                  // Add how to map through countries
                    //let countries = searchResults.ma
                    completion(.success(searchResults))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
            
        }
    }
}
