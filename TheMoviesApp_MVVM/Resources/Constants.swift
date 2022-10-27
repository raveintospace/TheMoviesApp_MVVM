//
//  Constants.swift
//  TheMoviesApp_MVVM
//  Common data for a global use in our app
//  Created by Uri on 24/10/22.
//

import Foundation

struct Constants {
    static let apiKey = "ca19366af5cdebc4b77d240a42ab15ad"
    
    struct URL {
        static let main = "https://api.themoviedb.org/"
        static let urlImages = "https://image.tmdb.org/t/p/w200"
    }
    
    struct Endpoints {
        static let urlListPopularMovies = "3/movie/popular"
        static let urlDetailMovie = "3/movie/"
    }
}
