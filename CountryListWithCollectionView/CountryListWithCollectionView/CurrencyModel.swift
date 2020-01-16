//
//  CurrencyModel.swift
//  CountryListWithCollectionView
//
//  Created by Yuliia Engman on 1/15/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import Foundation

struct Currency: Codable {
    let rates: [String: Double]
}
