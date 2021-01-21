//
//  listViewController.swift
//  GhibliMovies
//
//  Created by Cédric B. on 21/01/2021.
//

import UIKit

import Foundation
import Alamofire

private let reuseIdentifier = "Cell2"

class listFavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collView: UICollectionView!
    private var items: [[String:String]] = []
    
    private var listOfMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collView.delegate = self
        collView.dataSource = self
        
        loadMovies()
    }
    
    private func loadMovies() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let decoded  = UserDefaults.standard.object(forKey: "favorites") as? Data
            
            if (decoded != nil) {
                listOfMovies = try jsonDecoder.decode([Movie].self, from: decoded!)
            }
            
            self.collView.reloadData()
        } catch {
            print("error here")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return listOfMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: FavorisCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as? FavorisCollectionViewCell
        
        guard let sureCell = cell else {
            return UICollectionViewCell()
        }
        
        let navController = navigationController
        
        sureCell.fill(withMovie: listOfMovies[indexPath.row], withNav: navController!)
        
        return sureCell
    }
}
