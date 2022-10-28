//
//  ManagerConnections.swift
//  TheMoviesApp_MVVM
//  To manage the calls to our services / API Rests // Connection layer
//  Created by Uri on 25/10/22.
//

import Foundation
import RxSwift

class ManagerConnections {
    
    func getPopularMovies() -> Observable<[Movie]> {
        
        return Observable.create { observer in
            
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: Constants.URL.main+Constants.Endpoints.urlListPopularMovies)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            session.dataTask(with: request) { (data, response, error) in    // in -> closure! // initiates the call to the server
                
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return } // exit if any of these 3 things happens
                
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(Movies.self, from: data)    // to decode the json downloaded from our server
                        
                        observer.onNext(movies.listOfMovies)
                    } catch let error {
                        observer.onError(error)
                        print("An error has occured: \(error.localizedDescription)")
                    }
                }
                else if response.statusCode == 401 {
                    print("error 401")
                }
                observer.onCompleted()      // to inform that the observable has been completed
            }.resume()  // end of the return {}
            
            return Disposables.create {                  // to stop the object created and invalidate any current task
                session.finishTasksAndInvalidate()
            }
            
        }
    }
    
    func getDetailMovies() {
        
    }
}
