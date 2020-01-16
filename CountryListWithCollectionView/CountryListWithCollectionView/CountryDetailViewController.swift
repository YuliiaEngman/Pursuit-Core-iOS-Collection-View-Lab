//
//  CountryDetailViewController.swift
//  CountryListWithCollectionView
//
//  Created by Yuliia Engman on 1/15/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {
    
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    
    var oneCountry: Country?
    
    var currency: Currency?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func getCurrency(forKey: String) {
        ExchangeSearchAPIClient.fetchExchangeRate(completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error \(appError)")
            case .success(let exchangeRate):
                self?.currency = exchangeRate
            }
        })
    }
    
    func updateUI() {
        guard let oneCountry = oneCountry else {
            fatalError("could not get object from prepare for segue")
        }
        //        guard let currency = currency else {
        //            fatalError("could not get currency object")
        //        }
        countryName.text = oneCountry.name
        capitalLabel.text = "Capital: \(oneCountry.capital)"
        populationLabel.text = "Population of the country is \(oneCountry.population.description) people"
        
        let imageURL = "https://www.countryflags.io/\(oneCountry.alpha2Code)/shiny/64.png"
        
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
        
        let countryCurrency = oneCountry.currencies.first?.code ?? "no currency code"
        getCurrency(forKey: countryCurrency)
        currencyLabel.text = currency?.rates[countryCurrency]?.description
    }

}


