//
//  KeyTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-09.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class KeytTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreationForV4() {
        let model: Droplet.Key = self.modelNamed(name: "key")
        
        XCTAssertEqual(model.id,          123)
        XCTAssertEqual(model.name,        "john@John-Smiths-MBP")
        XCTAssertEqual(model.publicKey,   "ssh-rsa AB3")
        XCTAssertEqual(model.fingerprint, "b7:40")
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Droplet.Key.self, name: "key")
    }
}
