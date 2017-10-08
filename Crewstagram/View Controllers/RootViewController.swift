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


class RootViewController: UITableViewController {

    
    var coreDataStack: CoreDataStack!
    var imagesArray = [CrewImage]()
    let crewBaseURL: String = "http://alpha-web.crewapp.com/crewstagram"
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataStack = CoreDataStack()
        self.performLoad()
    }

    func performLoad() {
        coreDataStack.setup { (success) in
            if success {
                firstly{
                        self.retrieveCrewJSON()
                    }.then {_ in
                        self.startImageDownloading()
                    }.catch { error in
                    print("Crewstagram Imaege Connection")
                    }
                
            } else {
                    print("Crewstagram Core Date Init Failure")
            }
        }
    }

    
    func retrieveCrewJSON() -> Promise<AnyObject?> {
    
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        let adtesturl: String = "https://httpbin.org/get"
        let
        
        return Promise { fulfill, reject in
            Alamofire.request("https://httpbin.org/get").responseJSON { response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                }
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }
            }
        }
    
    }
    
    func startImageDownloading() -> Promise<AnyObject?> {
        
            return Promise { fulfill, reject in
//                Alamofire.request(url, method: .get, parameters: parameters, headers: headers)
//                    .validate(statusCode: 200..<300)
//                    .responseJSON { response in
//                        if response.result.isSuccess {
//                            fulfill(response.result.value as AnyObject?)
//                        } else {
//                            reject(response.result.error!)
//                        }
//                }
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
