//
//  CountryModel.swift
//  CountryListWithCollectionView
//
//  Created by Yuliia Engman on 1/14/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let name: String
    let alpha2Code: String
    let capital: String
    let population: Int
    let currencies: [Money]
}

struct Money: Decodable {
    let code: String
    let name: String
    let symbol: String
}
