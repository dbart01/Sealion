//
//  TagTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class TagTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreationWithDroplet() {
        let model:   Tag     = self.modelNamed(name: "tagWithDroplet")
        let droplet: Droplet = self.modelNamed(name: "droplet")
        
        XCTAssertEqual(model.name,        "some-tag")
        XCTAssertEqual(model.dropletCount, 1)
        XCTAssertEqual(model.lastDroplet,  droplet)
    }
    
    func testJsonCreationWithoutDroplet() {
        let model: Tag = self.modelNamed(name: "tagWithoutDroplet")
        
        XCTAssertEqual(model.name,        "some-tag")
        XCTAssertEqual(model.dropletCount, 0)
        XCTAssertEqual(model.lastDroplet,  nil)
    }
    
    func testEqualityWithDroplet() {
        self.assertEqualityForModelNamed(type: Tag.self, name: "tagWithDroplet")
    }
    
    func testEqualityWithoutDroplet() {
        self.assertEqualityForModelNamed(type: Tag.self, name: "tagWithoutDroplet")
    }
    
    // ----------------------------------
    //  MARK: - Create Request -
    //
    func testCreateRequest() {
        let name    = "cool"
        let request = Tag.CreateRequest(name: name)
        
        let json = request.json
        
        XCTAssertEqual(json["name"] as! String, name)
    }
}
