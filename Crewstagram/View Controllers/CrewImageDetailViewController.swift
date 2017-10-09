//
//  CrewImageDetailViewController.swift
//  Crewstagram
//
//  Created by Kerry Washington on 10/8/17.
//  Copyright © 2017 Grunt Software. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class CrewImageDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentCrewImage: CrewImage!
    var favoritesCounter: Int16 = 0
    var coreDataStack: CoreDataStack?
    var currentComments: [Comment]!
    
    @IBOutlet weak var crewImageView: UIImageView!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    
    @IBAction func addToFavorites(_ sender: Any) {
        favoritesCounter += 1
        self.favoriteLabel.text = String(describing:self.favoritesCounter)
        if let favoritedImageUUID = self.currentCrewImage.uuid as? String {
            print(favoritedImageUUID)
            self.markAsFavorite(uuid:favoritedImageUUID)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentComments = Array(currentCrewImage.comments!) as! [Comment]
        self.configureViews()
    }

    func configureViews() {
        favoritesCounter = self.currentCrewImage.favorites
        self.favoriteLabel.text = String(describing:self.currentCrewImage.favorites)
        self.crewImageView.image = UIImage(data: currentCrewImage.imageData as! Data)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func markAsFavorite(uuid: String) {
        currentCrewImage.setValue(favoritesCounter, forKey: "favorites")
        if let postingUUIDString = crewBaseURLString + "/" + uuid as? String {
            Alamofire.request(postingUUIDString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(response.result.value)
                    }
                    break
                    
                case .failure(_):
                    print(response.result.error)
                    break
                }
            }
        }
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentComments.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        let crewComment = self.currentComments[indexPath.row]
        cell.usernameLabel.text =  crewComment.username
        cell.commentsTextView.text = crewComment.body
        return cell
    }

}
