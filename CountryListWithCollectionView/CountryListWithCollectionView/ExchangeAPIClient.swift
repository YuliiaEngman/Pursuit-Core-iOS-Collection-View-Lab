//
//  ExchangeAPIClient.swift
//  CountryListWithCollectionView
//
//  Created by Yuliia Engman on 1/15/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import Foundation
import NetworkHelper

// should I add for Country.currency?

struct ExchangeSearchAPIClient {
    static func fetchExchangeRate(completion: @escaping(Result<[Currency], AppError>) -> ()) {
//        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "uk"
        
        // not secured - i think it will be a problem
        let currencyEndpointURL = "https://data.fixer.io/api/latest?access_key=a17aef5ece92cf36d9c5963f7f4babf1&format=1"
        
        guard let url = URL(string: currencyEndpointURL) else {
        completion(.failure(.badURL(currencyEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) {(result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode([Currency].self, from: data)
                    
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
