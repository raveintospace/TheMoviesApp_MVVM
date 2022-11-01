//
//  DetailView.swift
//  TheMoviesApp_MVVM
//
//  Created by Uri on 30/10/22.
//

import UIKit
import RxSwift

class DetailView: UIViewController {
    
    @IBOutlet private weak var titleHeader: UILabel!
    @IBOutlet private weak var imageFilm: UIImageView!
    @IBOutlet private weak var overviewMovie: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var originalTitle: UILabel!
    @IBOutlet private weak var voteAverage: UILabel!
    
    private var router = DetailRouter()
    private var viewModel = DetailViewModel()
    private var disposeBag = DisposeBag()
    var movieID: String?        // to communicate between VCs, that's why it's not private
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataAndShowDetailMovie()
        viewModel.bind(view: self, router: router)
    }
    
    private func getDataAndShowDetailMovie() {
        guard let idMovie = movieID else { return }     // check if we have a movieID or return
        
        return viewModel.getMovieData(movieID: idMovie).subscribe(
            onNext: { movie in
                self.showMovieData(movie: movie)
            },
            onError: { error in
                print("An error has occured: \(error)")
            },
            onCompleted: {
                }).disposed(by: disposeBag)
    }
    
    private func showMovieData(movie: MovieDetail) {
        DispatchQueue.main.async {    // Update the view on the main thread
            self.titleHeader.text = movie.title
            self.imageFilm.imageFromServerURL(urlString: Constants.URL.urlImages+movie.posterPath, placeHolderImage: UIImage(named: "claqueta")!)
            self.overviewMovie.text = movie.overview
            self.releaseDate.text = movie.releaseDate
            self.originalTitle.text = movie.originalTitle
            self.voteAverage.text = String(movie.voteAverage)
        }
    }
    
}
