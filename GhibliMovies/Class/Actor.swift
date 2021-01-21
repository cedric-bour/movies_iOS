//
//  Actor.swift
//  GhibliMovies
//
//  Created by Cédric B. on 21/01/2021.
//

import Foundation

class Actor: NSObject, Codable {
    var id: String?
    var surname: String?
    var name: String?
    var naissance: String?
    var lieu: String?
    var descriptions: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case id, surname, name, naissance, lieu, descriptions, url
    }
}
