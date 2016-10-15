//
//  FloatingIPTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class FloatingIPTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreationWithDroplet() {
        let model:   FloatingIP = self.modelNamed(name: "floatingIPWithDroplet")
        let droplet: Droplet    = self.modelNamed(name: "droplet")
        let region:  Region     = self.modelNamed(name: "region")
        
        
        XCTAssertEqual(model.ip,      "12.12.12.12")
        XCTAssertEqual(model.droplet, droplet)
        XCTAssertEqual(model.region,  region)
    }
    
    func testJsonCreationWithoutDroplet() {
        let model:  FloatingIP = self.modelNamed(name: "floatingIPWithoutDroplet")
        let region: Region     = self.modelNamed(name: "region")
        
        
        XCTAssertEqual(model.ip,      "12.12.12.12")
        XCTAssertEqual(model.region,  region)
        XCTAssertEqual(model.droplet, nil)
    }
    
    func testEqualityWithDroplet() {
        self.assertEqualityForModelNamed(type: FloatingIP.self, name: "floatingIPWithDroplet")
    }
    
    func testEqualityWithoutDroplet() {
        self.assertEqualityForModelNamed(type: FloatingIP.self, name: "floatingIPWithoutDroplet")
    }
    
    // ----------------------------------
    //  MARK: - Create Request Droplet -
    //
    func testCreateRequestDroplet() {
        let id      = 123
        let request = FloatingIP.CreateRequestDroplet(droplet: id)
        
        let json = request.json
        
        XCTAssertEqual(json["droplet_id"] as! Int, id)
    }
    
    func testCreateRequestRegion() {
        let region  = "nyc3"
        let request = FloatingIP.CreateRequestRegion(region: region)
        
        let json = request.json
        
        XCTAssertEqual(json["region"] as! String, region)
    }
}
