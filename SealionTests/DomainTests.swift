//
//  DomainTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-14.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

import XCTest
import Sealion

class DomainTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: Domain = self.modelNamed(name: "domain")
        
        XCTAssertEqual(model.name, "example.com")
        XCTAssertEqual(model.ttl,  1800)
        
        XCTAssertNotNil(model.zone)
        XCTAssertTrue(model.zone!.characters.count > 0)
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Domain.self, name: "domain")
    }
    
    // ----------------------------------
    //  MARK: - Create Request -
    //
    func testCreateRequest() {
        let ip      = "12.12.12.12"
        let name    = "example.com"
        let request = Domain.CreateRequest(ip: ip, name: name)
        
        let json = request.json
        
        XCTAssertEqual(json["ip"]   as! String, ip)
        XCTAssertEqual(json["name"] as! String, name)
    }
}
