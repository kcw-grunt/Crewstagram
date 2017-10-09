//
//  UIImageView+Additions.swift
//  Crewstagram
//
//  Created by Kerry Washington on 10/8/17.
//  Copyright © 2017 Grunt Software. All rights reserved.
//

import UIKit

extension UIImageView {
    func imageFromCrewServerURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
    
}
