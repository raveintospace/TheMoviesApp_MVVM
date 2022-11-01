//
//  MovieDetail.swift
//  TheMoviesApp_MVVM
//  Data model for our detailview.
//  We only send a movieID from the mainVC, the rest of the data is downloaded from the api using movieID
//  Created by Uri on 31/10/22.
//

import Foundation

struct MovieDetail: Codable {
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    let homepage: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case homepage
        case voteAverage = "vote_average"
    }
    
}
