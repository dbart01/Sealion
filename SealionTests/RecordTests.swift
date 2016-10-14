//
//  RecordTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-14.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class RecordTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: Record = self.modelNamed(name: "record")
        
        XCTAssertEqual(model.id,       123)
        XCTAssertEqual(model.kind,     Record.Kind(rawValue: "MX")!)
        XCTAssertEqual(model.name,     "@")
        XCTAssertEqual(model.value,    "mail.example.com")
        XCTAssertEqual(model.priority, 1)
        XCTAssertEqual(model.port,     80)
        XCTAssertEqual(model.weight,   10)
    }
    
    func testJsonCreationWithNullValues() {
        let model: Record = self.modelNamed(name: "recordWithNull")
        
        XCTAssertEqual(model.id,       123)
        XCTAssertEqual(model.kind,     Record.Kind(rawValue: "A")!)
        XCTAssertEqual(model.name,     "@")
        XCTAssertEqual(model.value,    "example.com")
        XCTAssertEqual(model.priority, nil)
        XCTAssertEqual(model.port,     nil)
        XCTAssertEqual(model.weight,   nil)
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Record.self, name: "record")
    }
}
