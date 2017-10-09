//
//  CrewJSON.swift
//  Crewstagram
//
//  Created by Kerry Washington on 10/9/17.
//  Copyright © 2017 Grunt Software. All rights reserved.
//

import UIKit
import PromiseKit
import CoreData
import Alamofire

//private let crewBaseURLString: String = "http://alpha-web.crewapp.com/crewstagram"

class CrewJSON: NSObject {
//
//    func retrieveCrewJSON() -> Promise<[CrewImage]> {
//        return Promise { fulfill, reject in
//            Alamofire.request(URL(string:crewBaseURLString)!, method: .get, parameters: nil, headers: nil)
//                .validate(statusCode: 200..<300)
//                .responseJSON { response in
//                    if response.result.isSuccess {
//                        if let images = response.result.value as? [String:Any], let imagesArray = images["images"] as? Array<[String:Any]> {
//                            
//                            for image in imagesArray {
//                                if let uuid = image["uuid"]! as? String, let imageUrlString = image["imageUrl"]! as? String , let favorites = image["favorites"] as? Int16, let crewImage = self.findMatchOrCreateCrewImage(uuid: uuid) as? CrewImage {
//                                    crewImage.uuid = uuid
//                                    crewImage.imageUrlString = imageUrlString
//                                    crewImage.favorites = favorites
//                                    if crewImage.comments?.count == 0 {
//                                        if let comments = image["comments"] as? Array<[String:Any]> {
//                                            for comment in comments {
//                                                if let cdComment  =  NSEntityDescription.insertNewObject(forEntityName: "Comment", into: self.coreDataStack.backgroundContext) as? Comment,
//                                                    let body = comment["body"] as? String, let username = comment["username"] as? String {
//                                                    cdComment.body = body
//                                                    cdComment.username = username
//                                                    crewImage.addToComments(cdComment)
//                                                }
//                                            }
//                                        }
//                                        self.imagesArray.append(crewImage)
//                                    }
//                                } else {
//                                    print("crewImage not initialized nor found")
//                                }
//                            }
//                            self.tableView.reloadData()
//                        }
//                        fulfill(response.result.value as AnyObject?)
//                    } else {
//                        reject(response.result.error!)
//                    }
//            }
//        }
//    }
}
