//
//  ViewController.swift
//  CountryListWithCollectionView
//
//  Created by Yuliia Engman on 1/14/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var countries = [Country]() {
           didSet {
               DispatchQueue.main.async {
                   self.collectionView.reloadData()
               }
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
       collectionView.delegate = self
        collectionView.backgroundColor = .blue
        
        fetchCountry(searchQuery: "un")
    }
    
    private func fetchCountry(searchQuery: String) {
        CountrySearchAPIClient.fetchCountry(for: searchQuery) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("could not fetch dog image with error: \(appError)")
            case .success(let countries):
                self?.countries = countries
            }
        }
    }
}


extension CountryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCollectionViewCell else {
            fatalError("could not downcast to CountryCell")
    }
        let country = countries[indexPath.row]
        cell.configureCell(for: country)
        return cell
    }
}


// here we are using UICollectionViewFlowLayout

extension CountryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // let interItemSpacing: CGFloat = 10 // space between items
        let maxWidth = UIScreen.main.bounds.size.width // device's width
        //let numberOfItems: CGFloat = 3 // items
        let numberOfItems: CGFloat = 1
       // let totalSpacing: CGFloat = numberOfItems * interItemSpacing
       // let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        let itemWidth: CGFloat = maxWidth / numberOfItems
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

//extension DogViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let interItemSpacing: CGFloat = 10 // space between items
//        let maxWidth = UIScreen.main.bounds.size.width // device's width
//        let numberOfItems: CGFloat = 3 // items
//        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
//        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
//
//        return CGSize(width: itemWidth, height: itemWidth)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//
//}

