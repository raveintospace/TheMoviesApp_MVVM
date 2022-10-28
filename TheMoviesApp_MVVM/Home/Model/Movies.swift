//
//  Movies.swift
//  TheMoviesApp_MVVM
//  Data of our app
//  Created by Uri on 25/10/22.
//

import Foundation

struct Movies: Codable {
    let listOfMovies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case listOfMovies = "results"       // results is the main key of the json
    }
}

struct Movie: Codable {     // Codable lets us serialize our data
    let title: String
    let popularity: Double
    let movieID: Int
    let voteCount: Int
    let originalTitle: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String
    let image: String
    
    enum CodingKeys: String, CodingKey {   // enum to link our names with the names of the json
        case title
        case popularity
        case movieID = "id"
        case voteCount = "vote_count"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case image = "poster_path"
    }
}

