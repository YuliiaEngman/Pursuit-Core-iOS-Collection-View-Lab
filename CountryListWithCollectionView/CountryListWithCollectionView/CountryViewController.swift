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
        collectionView.backgroundColor = .gray
        searchBar.delegate = self
        
        searchCountry(searchQuery: "")
       // navigationItem.title = "Country Search"
    }
    
    private func searchCountry(searchQuery: String) {
        CountrySearchAPIClient.fetchCountry(for: searchQuery, completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error \(appError)")
            case .success(let countries):
                self?.countries = countries
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? CountryDetailViewController, let indexPath = collectionView.indexPath(for: sender as! CountryCollectionViewCell) else {
            fatalError("failed to get indexPath and detailVC")
        }
        let someCountry = countries[indexPath.row]
        detailVC.oneCountry = someCountry
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
        cell.backgroundColor = .orange
        return cell
    }
}


// here we are using UICollectionViewFlowLayout

extension CountryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 10 // space between items
        let maxWidth = UIScreen.main.bounds.size.width // device's width
        let numberOfItems: CGFloat = 2 // items
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        
        return CGSize(width: itemWidth, height: 300)
    }
}

extension CountryViewController: UISearchBarDelegate {
    // this will activate search bar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        // we will use guard let to unwrap the searchbar property because its an optional
        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        searchCountry(searchQuery: searchText)
    }
}
