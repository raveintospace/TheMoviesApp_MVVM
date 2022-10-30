//
//  DetailView.swift
//  TheMoviesApp_MVVM
//
//  Created by Uri on 30/10/22.
//

import UIKit

class DetailView: UIViewController {
    
    @IBOutlet private weak var titleHeader: UILabel!
    @IBOutlet private weak var imageFilm: UIImageView!
    @IBOutlet private weak var overviewMovie: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var originalTitle: UILabel!
    @IBOutlet private weak var voteAverage: UILabel!
    
    private var movieID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
