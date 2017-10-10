//
//  RootViewController.swift
//  Crewstagram
//
//  Created by Kerry Washington on 10/7/17.
//  Copyright © 2017 Grunt Software. All rights reserved.
//

import UIKit
import CoreData
import PromiseKit
import Alamofire

let crewBaseURLString: String = "http://alpha-web.crewapp.com/crewstagram"

class RootViewController: UITableViewController, CrewImageDelegate {
    
    var coreDataStack: CoreDataStack!
    var imagesArray = [CrewImage]()
    var selectedCrewImage: CrewImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Crewstagram"
        coreDataStack = CoreDataStack()
        self.performLoad()
    }

    func didUpdateFavoriteCount(newCount:Int16, uuid:String) {
        if let crewIndex = self.imagesArray.index(where:{$0.uuid == uuid}) {
            let indexPath = IndexPath(row: crewIndex, section: 0)
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    func performLoad() {
        coreDataStack.setup { (success) in
            if success {
                firstly{
                        self.retrieveCrewJSON()
                    }.then {_ in
                        self.startImageDownloading()
                    }.catch { error in
                    print("Crewstagram Image Connection Error")
                    }
            } else {
                print("Crewstagram Core Data Init Failure")
            }
        }
    }

    func retrieveCrewJSON() -> Promise<AnyObject?> {
        return Promise { fulfill, reject in
            Alamofire.request(URL(string:crewBaseURLString)!, method: .get, parameters: nil, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    if response.result.isSuccess {
                        if let images = response.result.value as? [String:Any], let imagesArray = images["images"] as? Array<[String:Any]> {
                            
                            for image in imagesArray {
                                if let uuid = image["uuid"]! as? String, let imageUrlString = image["imageUrl"]! as? String , let favorites = image["favorites"] as? Int16, let crewImage = self.findMatchOrCreateCrewImage(uuid: uuid) {
                                         crewImage.uuid = uuid
                                         crewImage.imageUrlString = imageUrlString
                                         crewImage.favorites = favorites
                                        if crewImage.comments?.count == 0 {
                                            if let comments = image["comments"] as? Array<[String:Any]> {
                                                for comment in comments {
                                                    if let cdComment  =  NSEntityDescription.insertNewObject(forEntityName: "Comment", into: self.coreDataStack.backgroundContext) as? Comment,
                                                        let body = comment["body"] as? String, let username = comment["username"] as? String {
                                                        cdComment.body = body
                                                        cdComment.username = username
                                                        crewImage.addToComments(cdComment)
                                                    }
                                                }
                                            }
                                            self.imagesArray.append(crewImage)
                                        }
                                } else {
                                    print("crewImage not initialized nor found")
                                }
                            }
                        }
                        fulfill(response.result.value as AnyObject?)
                        self.tableView.reloadData()
                    } else {
                        reject(response.result.error!)
                    }
            }
        }
    }
    
    func startImageDownloading() {
        var counter = 0
        for image in imagesArray {
            guard let uuid = image.uuid else {
                print("Crew Image UUID Found")
                return
            }
            guard let imageUrl = image.imageUrlString else {
                print("Crew Image URL Not Found")
                return
            }
            guard let url = URL(string: imageUrl) else {
                print("Crew Image Not Found")
                return
            }
            counter += 1
            Alamofire.request(url).responseData(completionHandler: { response in
                 if let crewImage = response.result.value {
                    let image = UIImage(data: crewImage)
                   self.updateCrewImage(uuid:uuid, newImage: image!)
                    if counter == self.imagesArray.count {
                        self.tableView.reloadData()
                    }
                }
            })
        }
    }
    
    func findMatchOrCreateCrewImage(uuid:String) -> CrewImage? {
        do {
            let imageRequest : NSFetchRequest<CrewImage> = CrewImage.fetchRequest()
            imageRequest.predicate = NSPredicate(format: "uuid == %@", uuid)
            let fetchedResults = try coreDataStack.backgroundContext.fetch(imageRequest) as! [CrewImage]
            if let foundImage = fetchedResults.first {
                return foundImage
            } else {
                if let newCrewImage = NSEntityDescription.insertNewObject(forEntityName: "CrewImage", into: self.coreDataStack.backgroundContext) as? CrewImage {
                    return newCrewImage
                }
            }
        } catch {
            print ("Find or Create fetch task failed", error)
        }
        return nil
    }
    
    func updateCrewImage(uuid:String, newImage: UIImage) {
        do {
            let imageRequest : NSFetchRequest<CrewImage> = CrewImage.fetchRequest()
            imageRequest.predicate = NSPredicate(format: "uuid == %@", uuid)
            let fetchedResults = try coreDataStack.backgroundContext.fetch(imageRequest) as! [CrewImage]
            if let foundImage = fetchedResults.first {
                foundImage.imageData = UIImagePNGRepresentation(newImage)! as NSData
                print("saved data")
            }
        }
        catch {
            print ("fetch task failed", error)
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imagesArray.count
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CrewImageCell", for: indexPath) as! CrewImageTableViewCell
        let crewImage = self.imagesArray[indexPath.row]
        cell.favoriteLabel.text =  String(crewImage.favorites)
        let url = URL(string: crewImage.imageUrlString!)
        
        if crewImage.imageData?.length == 0 {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    crewImage.imageData = data as! NSData
                    cell.crewImageView?.image = UIImage(data: data!)
                    let testImage = UIImage(data: data!)
                }
            }
        } else {
            if let existingImage = crewImage.imageData {
                cell.crewImageView?.image = UIImage(data: existingImage as Data)
            }
        }
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCrewImage = self.imagesArray[indexPath.row]
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier:"CrewImageDetailViewController") as! CrewImageDetailViewController
        detailViewController.currentCrewImage = self.selectedCrewImage
        detailViewController.coreDataStack = self.coreDataStack
        detailViewController.delegate = self
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
