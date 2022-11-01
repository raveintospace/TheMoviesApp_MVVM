//
//  DetailViewModel.swift
//  TheMoviesApp_MVVM
//
//  Created by Uri on 31/10/22.
//

import Foundation
import RxSwift

class DetailViewModel {
    private var managerConnections = ManagerConnections()
    private(set) weak var view: DetailView?     // private(set) = public to read, private to set a value
    private var router: DetailRouter?
    
    func bind(view: DetailView, router: DetailRouter) {
        self.view = view
        self.router = router
        
        // set the view on the router
        self.router?.setSourceView(view)
    }
    
    func getMovieData(movieID: String) -> Observable<MovieDetail> {
        return managerConnections.getDetailMovies(movieID: movieID)
    }
    
}
