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
    
    
    var oneCountry: Country?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let oneCountry = oneCountry else {
            fatalError("could not get object from prepare for segue")
        }
        countryName.text = oneCountry.name
        capitalLabel.text = oneCountry.capital
        populationLabel.text = oneCountry.population.description
        
    
    }

}
