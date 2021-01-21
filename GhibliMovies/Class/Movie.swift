//
//  Movie.swift
//  GhibliMovies
//
//  Created by Cédric B. on 21/01/2021.
//

import Foundation

class Movie: NSObject, Codable {
    var id: String?
    var title: String?
    var descriptions: String?
    var director: String?
    var producer: String?
    var release_date: String?
    var rt_score: String?
    var url: String?
    var director2: Actor?
    var producer2: Actor?
    
    enum CodingKeys: String, CodingKey {
        case id, title, descriptions, director, producer, release_date, rt_score, url
    }
}
