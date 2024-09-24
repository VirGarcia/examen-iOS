//
//  Movie.swift
//  examen-iOS
//
//  Created by Mañanas on 24/9/24.
//

import Foundation
import UIKit

struct Movies : Codable {
    let response: String
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case movies = "Search"
    }
}

struct Movie: Codable {
    let id: String
    let title: String
    let year: String
    let type: String
    let poster: String
    let plot: String?
    let runtime: String?
    let director: String?
    let genre: String?
    let country: String?
    
    enum CodingKeys: String, CodingKey {
       case id = "imdbID"
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
        case plot = "Plot"
        case runtime = "Runtime"
        case director = "Director"
        case genre = "Genre"
        case country = "Country"
        
    }
   
}



    
    

