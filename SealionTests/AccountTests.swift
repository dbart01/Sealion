//
//  AccountTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-07.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class AccountTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: Account = self.modelNamed(name: "account")
        
        XCTAssertEqual(model.dropletLimit,    25)
        XCTAssertEqual(model.floatingIPLimit, 3)
        XCTAssertEqual(model.verified, true)
        XCTAssertEqual(model.email,    "john.smith@gmail.com")
        XCTAssertEqual(model.status,   "active")
        XCTAssertEqual(model.message,  "Everything is okay")
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Account.self, name: "account")
    }
}
