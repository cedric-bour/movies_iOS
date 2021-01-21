//
//  CollectionViewCell.swift
//  GhibliMovies
//
//  Created by Cédric B. on 20/01/2021.
//

import UIKit


class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    
    private var movie: Movie?
    
    private var navController: UINavigationController?
    
    func fill(withMovie movie: Movie, withNav navController: UINavigationController) {
        
        self.movie = movie
        self.navController = navController
        
        let data = try? Data(contentsOf: URL(string: movie.url!)!)
        
        if let imageData = data {
            cellImageView.image = UIImage(data: imageData)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cellImageView.isUserInteractionEnabled = true
        cellImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "movieDetail") as! movieViewController
        
        vc.setMovie(withMovie: movie!)
        
        navController!.pushViewController(vc, animated: true)
    }
}
