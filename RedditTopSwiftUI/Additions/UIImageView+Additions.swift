//
//  UIImageView+Additions.swift
//  RedditTop
//
//  Created by Sergey Khliustin on 4/11/19.
//  Copyright © 2019 Sergey Khliustin. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFromURL(_ url: URL) {
        self.isHidden = false
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        self.addSubview(indicator)
        indicator.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        indicator.startAnimating()
        self.image = nil
        
        let completion: (_ image: UIImage?) -> () = { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
                indicator.stopAnimating()
                indicator.removeFromSuperview()
                self?.isHidden = image == nil
            }
        }
        
        DispatchQueue.global().async {
            let cache = URLCache.shared
            let request = URLRequest(url: url)
            if let response = cache.cachedResponse(for: request), let image = UIImage(data: response.data) {
                completion(image)
            }
            else {
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    var resultImage: UIImage? = nil
                    
                    if let data = data, let response = response, let image = UIImage(data: data) {
                        let cachedResponse = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedResponse, for: request)
                        resultImage = image
                    }
                    completion(resultImage)
                    
                    }.resume()
            }
        }
    }
}
