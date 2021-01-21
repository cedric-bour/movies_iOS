//
//  movieViewController.swift
//  GhibliMovies
//
//  Created by Cédric B. on 20/01/2021.
//

import UIKit

class actorViewController: UIViewController {
    
    private var movie: Movie?
//
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var nameText: UITextView!

    @IBOutlet weak var surnameText: UITextView!

    @IBOutlet weak var cityText: UITextView!

    @IBOutlet weak var birthText: UITextView!

    @IBOutlet weak var descriptionText: UITextView!
//
    override func viewDidLoad() {
        super.viewDidLoad()

        let data = try? Data(contentsOf: URL(string: (movie!.director2?.url)!)!)

        if let imageData = data {
            imageView.image = UIImage(data: imageData)
        }

        nameText.text = "Name: " + (movie!.director2?.name)!
        surnameText.text = "Surname: " + (movie!.director2?.surname)!
        birthText.text = "Birth: " + (movie!.director2?.naissance)!
        cityText.text = "City: " + (movie!.director2?.lieu)!
        descriptionText.text = "Description: " + (movie!.director2?.descriptions)!

    }
//
    func setMovie(withMovie movie: Movie) {
        self.movie = movie
    }
}
