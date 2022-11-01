//
//  HomeView.swift
//  TheMoviesApp_MVVM
//
//  Created by Uri on 18/10/22.
//

import UIKit
import RxSwift      // reactivity for our logic & data
import RxCocoa      // reactivity for our ui elements

class HomeView: UIViewController {
    
    // MARK: - Private vars
    
    @IBOutlet private weak var tableView: UITableView!          // private to invalidate this var being called from another class
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()           // used for rxswift
    private var movies = [Movie]()
    private var filteredMovies = [Movie]()
    
    lazy var searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .black
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.placeholder = "Search movie title"
        return controller
    })()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "The Movies App"
        configureTableView()
        viewModel.bind(view: self, router: router)
        getData()
        manageSearchBarController()
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
        DispatchQueue.main.async {          // main thread because we are updating the ui view!
            self.activity.stopAnimating()
            self.activity.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    private func manageSearchBarController() {
        let searchBar = searchController.searchBar
        searchController.delegate = self
        tableView.tableHeaderView = searchBar
        tableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height) // put our searchBarController at the top of our tableView
        
        searchBar.rx.text           // filter the results, searches for titles
            .orEmpty
            .distinctUntilChanged()
                .subscribe(onNext: { (result) in                    // subscribe to our search bar
                    self.filteredMovies = self.movies.filter({ movie in
                        self.reloadTableView()
                        return movie.title.contains(result)
                    })
                })
            .disposed(by: disposeBag)
    }
    
}

    // MARK: - Extensions

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return self.filteredMovies.count
        }
        else {
            return self.movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMovieCell") as! CustomMovieCell
        
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.imageMovie.imageFromServerURL(urlString: "\(Constants.URL.urlImages+self.filteredMovies[indexPath.row].image)", placeHolderImage: UIImage(named: "claqueta")!)
            cell.titleMovieLabel?.text = filteredMovies[indexPath.row].title
            cell.descriptionMovieLabel?.text = filteredMovies[indexPath.row].overview
        }
        else {
            cell.imageMovie.imageFromServerURL(urlString: "\(Constants.URL.urlImages+self.movies[indexPath.row].image)", placeHolderImage: UIImage(named: "claqueta")!)
            cell.titleMovieLabel?.text = movies[indexPath.row].title
            cell.descriptionMovieLabel?.text = movies[indexPath.row].overview
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
            viewModel.makeDetailView(movieID: String(self.filteredMovies[indexPath.row].movieID))
        }
        else {
            viewModel.makeDetailView(movieID: String(self.movies[indexPath.row].movieID))            
        }
    }
}

extension HomeView: UISearchControllerDelegate {        // to cancel the search and reload data when cancel button is clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        reloadTableView()
    }
}
