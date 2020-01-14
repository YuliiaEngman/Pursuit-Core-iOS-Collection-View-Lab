//
//  CountryCollectionViewCell.swift
//  CountryListWithCollectionView
//
//  Created by Yuliia Engman on 1/14/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import ImageKit

class CountryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    

    
    public func configureCell(for country: Country) {
        countryNameLabel.text = country.name
        capitalLabel.text = country.capital
        populationLabel.text = country.population.description
        
        let imageURL = "https://www.countryflags.io/\(country.alpha2Code)/shiny/64.png"
        
        countryImage.getImage(with: imageURL) {(result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.countryImage.image = UIImage(systemName: "photo.fill")
                }
            case .success(let countryImage):
                DispatchQueue.main.async {
                    self.countryImage.image = countryImage
                }
            }
        }
    }
}
