//
//  Extensions.swift
//  TheMoviesApp_MVVM
//
//  Created by Uri on 30/10/22.
//

import UIKit

extension UIImageView {     // to import images from the api and insert them in CustomMovieCell
    
    func imageFromServerURL(urlString: String, placeHolderImage: UIImage) {
        
        if self.image == nil {          // to load a default image if we can't import an image from the api
            self.image = placeHolderImage
        }
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            
            if error != nil {   // return if we have an error, will show the default image
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                let image = UIImage(data: data)
                self.image = image
            }
            
        }.resume()  // to call dataTask
    }
}
