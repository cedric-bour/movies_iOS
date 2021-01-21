//
//  listViewController.swift
//  GhibliMovies
//
//  Created by Cédric B. on 21/01/2021.
//

import UIKit

import Foundation
import Alamofire

private let reuseIdentifier = "Cell"

class listViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var items: [[String:String]] = []
    
    @IBOutlet weak var collView: UICollectionView!
    
    @IBOutlet weak var favoView: UIImageView!
    
    private var listOfMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collView.delegate = self
        collView.dataSource = self
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        favoView.isUserInteractionEnabled = true
        favoView.addGestureRecognizer(tapGestureRecognizer)
    
        loadMovies()
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "viewFavorites") as! listFavoritesViewController
        
        let navController = navigationController
        navController!.pushViewController(vc, animated: true)
    }

    private func loadMovie(val num: Int) {
        AF
            .request("http://92.222.22.146:3000/movies?number=" + String(num))
            .validate(statusCode: [200])
            .responseDecodable(of: Movie.self) {[weak self] (resp) in
                switch resp.result {
                case .success(let movieCreated):
                    
                    AF.request("http://92.222.22.146:3000/actors?number=" + String(movieCreated.director!))
                    .validate(statusCode: [200])
                    .responseDecodable(of: Actor.self) {[weak self] (resp) in
                        switch resp.result {
                        case .success(let directorCreate):
                            movieCreated.director2 = directorCreate
                            
                            AF.request("http://92.222.22.146:3000/actors?number=" + String(movieCreated.producer!))
                            .validate(statusCode: [200])
                            .responseDecodable(of: Actor.self) {[weak self] (resp) in
                                switch resp.result {
                                case .success(let productorCreate):
                                    movieCreated.producer2 = productorCreate
                                    
                                    self?.listOfMovies.append(movieCreated)
                                    self?.collView.reloadData()
                                case .failure(let error):
                                    print(error)
                                }
                            }
                            .responseString { (stringResponse) in
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                    .responseString { (stringResponse) in
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
            .responseString { (stringResponse) in
            }
    }
    
    private func loadMovies() {
        
        AF
            .request("http://92.222.22.146:3000/movies_number")
            .validate(statusCode: [200])
            .responseDecodable(of: Int.self) {[weak self] (resp) in
                switch resp.result {
                case .success(let moviesNumber):
                    var num = 0
                    for _ in 0...moviesNumber {
                        self?.loadMovie(val: num)
                        num = num + 1
                    }
                case .failure(let error):
                    print(error)
                }
            }
            .responseString { (stringResponse) in
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
        
        let cell: CollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell
        
        guard let sureCell = cell else {
            return UICollectionViewCell()
        }
        
        let navController = navigationController
        
        sureCell.fill(withMovie: listOfMovies[indexPath.row], withNav: navController!)
        
        return sureCell
    }
}
