//
//  MovieDetail.swift
//  TheMoviesApp_MVVM
//  Data model for our detailview.
//  We only send a movieID from the mainVC, the rest of the data is downloaded from the api using movieID
//  Created by Uri on 31/10/22.
// https://youtu.be/R7PBJ9VCPXw?list=PLaGK9OPKkB9fBzKQ4GHNkZIC1N5Wpv15m - app.quicktype.io

import Foundation

struct MovieDetail: Codable {
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    let originalTitle: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
    }
    
}
