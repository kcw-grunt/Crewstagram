//
//  CrewstagramTests.swift
//  CrewstagramTests
//
//  Created by Kerry Washington on 10/6/17.
//  Copyright © 2017 Grunt Software. All rights reserved.
//

import XCTest
import CoreData
import Alamofire
@testable import Crewstagram

class CrewstagramTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testImageDownloadTime() {
        self.measure {
            // Put the code you want to measure the time of here.
             ///1. Call Crew API JSON
        }
    }
    
    func testJSONImagesCountAndCoreDataImages() {
        
        ///1. Call Crew API JSON
        
        ///2. Count number of CoreData Crew Images
        
        ///3. Compare the two
        
    }
    
}
