//
//  NetworkTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-08.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class NetworkTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: Network = self.modelNamed(name: "v4Network")
        
        XCTAssertEqual(model.type,    "public")
        XCTAssertEqual(model.ip,      "12.12.123.12")
        XCTAssertEqual(model.netmask, "255.255.255.0")
        XCTAssertEqual(model.gateway, "12.12.192.1")
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Network.self, name: "v4Network")
    }
}
