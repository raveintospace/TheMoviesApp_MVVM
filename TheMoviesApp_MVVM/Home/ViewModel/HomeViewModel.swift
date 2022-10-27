//
//  HomeViewModel.swift
//  TheMoviesApp_MVVM
//  Logic of our app
//  Created by Uri on 18/10/22.
//

import Foundation

class HomeViewModel {
    private weak var view: HomeView?    // weak so everytime a new HomeView is created deletes the previous one
    private var router: HomeRouter?
    
    func bind(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)    // bind our view with our router
    }
}
