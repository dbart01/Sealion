//
//  RegionTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-07.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class RegionTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: Region = self.modelNamed(name: "region")
        
        XCTAssertEqual(model.available, true)
        XCTAssertEqual(model.name,      "New York 3")
        XCTAssertEqual(model.slug,      "nyc3")
        XCTAssertEqual(model.sizes, [
            "2gb", "4gb", "8gb",
        ])
        XCTAssertEqual(model.features, [
            "backups", "ipv6",
        ])
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Region.self, name: "region")
    }
}
