//
//  DetailRouter.swift
//  TheMoviesApp_MVVM
//  It has to send to our DetailView the movieID selected on the mainVC
//  Created by Uri on 31/10/22.
//

import UIKit

class DetailRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    var movieID: String?
    private var sourceView: UIViewController?   // assigns the view used for our HomeRouter
    
    init(movieID: String? = "") {
        self.movieID = movieID
    }
    
    // bind our view with our Router
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else {fatalError("Unknown error")}
        
        self.sourceView = view
    }
    
    private func createViewController() -> UIViewController {
        let view = DetailView(nibName: "DetailView", bundle: Bundle.main)
        view.movieID = self.movieID         // assign the movieID we are receiving to the DetailView movieID
        return view
    }
}
