//
//  movieViewController.swift
//  GhibliMovies
//
//  Created by Cédric B. on 20/01/2021.
//

import UIKit

class movieViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleText: UITextView!
    
    @IBOutlet weak var directorText: UITextView!
    
    @IBOutlet weak var ProducerText: UITextView!
    
    @IBOutlet weak var releaseDateText: UITextView!
    
    @IBOutlet weak var starText: UITextView!
    
    @IBOutlet weak var descriptionView: UITextView!
    
    @IBOutlet weak var favortiesView: UIImageView!
    
    private var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = try? Data(contentsOf: URL(string: movie!.url!)!)
        
        if let imageData = data {
            imageView.image = UIImage(data: imageData)
        }
        
        titleText.text = "Title: " + movie!.title!
        directorText.text = "Director: " + (movie!.director2?.surname!)! + " " + (movie!.director2?.name!)!
        ProducerText.text = "Producer: " + (movie!.producer2?.surname!)! + " " + (movie!.producer2?.name!)!
        releaseDateText.text = "Release Date: " + movie!.release_date!
        starText.text = "Score: " + movie!.rt_score!
        descriptionView.text = "Description: " + movie!.descriptions!
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        directorText.isUserInteractionEnabled = true
        directorText.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer2:)))
        favortiesView.isUserInteractionEnabled = true
        favortiesView.addGestureRecognizer(tapGestureRecognizer2)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "actorsDetail") as! actorViewController
        
        vc.setMovie(withMovie: movie!)
        
        let navController = navigationController
        
        navController!.pushViewController(vc, animated: true)
    }
    
    @objc func imageTapped2(tapGestureRecognizer2: UITapGestureRecognizer)
    {
        do {
            
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(movie)
            let json = String(data: jsonData, encoding: String.Encoding.utf16)
            UserDefaults.standard.setValue(json, forKey: "favorites")
            
            let decoded  = UserDefaults.standard.object(forKey: "favorites") as? String
            let jsonDecoder = JSONDecoder()
            let secondDog = try jsonDecoder.decode(Movie.self, from: decoded as! Data)
//
//            print(secondDog.title!)
        } catch {
            print("error here")
        }
    }
    
    
    func setMovie(withMovie movie: Movie) {
        self.movie = movie
    }
}
