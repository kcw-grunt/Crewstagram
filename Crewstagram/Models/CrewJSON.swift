//
//  CrewJSON.swift
//  Crewstagram
//
//  Created by Kerry Washington on 10/9/17.
//  Copyright © 2017 Grunt Software. All rights reserved.
//

import UIKit
import CoreData
import Alamofire


//private let crewBaseURLString: String = "http://alpha-web.crewapp.com/crewstagram"

class CrewJSON: NSObject {
 
    func retrieveCrewJSONObject() -> Array<[String:Any]> {
        var imagesArray = Array<[String:Any]>()
            Alamofire.request(URL(string:crewBaseURLString)!, method: .get, parameters: nil, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    if response.result.isSuccess {
                        if let images = response.result.value as? [String:Any], let array = images["images"] as? Array<[String:Any]> {
                            imagesArray = array
                        }
                    } else {
                        print("Error D/L")
                    }
        }
        return imagesArray
    }
}

