//
//  HomeView.swift
//  TheMoviesApp_MVVM
//
//  Created by Uri on 18/10/22.
//

import UIKit
import RxSwift

class HomeView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    private var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        viewModel.bind(view: self, router: router)
        getData()
    }
    
    
// MARK: - Private funcs
    
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension    // height of cell will be automatic, according to its content
        tableView.register(UINib(nibName: "CustomMovieCell", bundle: nil), forCellReuseIdentifier: "CustomMovieCell")
    }
    
    // func to call our data when the app is opened
    private func getData() {
        return viewModel.getListMoviesData()
        
            .subscribeOn(MainScheduler.instance)    // to be executed on the main thread -> concurrency!
            .observeOn(MainScheduler.instance)
        
            .subscribe(                  // to subscribe to the observable
                onNext: { movies in
                    self.movies = movies
                    self.reloadTableView()
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {           // we do nothing when we finish getting our movies
            }).disposed(by: disposeBag)

    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.activity.stopAnimating()
            self.activity.isHidden = true
            self.tableView.reloadData()
        }
    }
}

// MARK: - Extensions

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMovieCell") as! CustomMovieCell
        
        cell.titleMovieLabel?.text = movies[indexPath.row].title
        cell.descriptionMovieLabel?.text = movies[indexPath.row].overview
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
