//
//  HomeRouter.swift
//  TheMoviesApp_MVVM
//
//  Created by Uri on 18/10/22.
//

// Creates our object Home and also works as a router to go to other views
import Foundation
import UIKit

class HomeRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceView: UIViewController?   // assigns the view used for our HomeRouter
    
    private func createViewController() -> UIViewController {
        let view = HomeView(nibName: "HomeView", bundle: Bundle.main)
        return view
    }
    
    // bind our view with our Router
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else {fatalError("Unknown error")}
        
        self.sourceView = view
    }
    
}
