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
        XCTAssertTrue(model.zone.characters.count > 0)
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Domain.self, name: "domain")
    }
}
