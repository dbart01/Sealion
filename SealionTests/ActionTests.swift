//
//  ActionTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-07.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class ActionTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: Action = self.modelNamed(name: "action")
        
        XCTAssertEqual(model.id,           123)
        XCTAssertEqual(model.resourceID,   456)
        XCTAssertEqual(model.status,       "completed")
        XCTAssertEqual(model.type,         "image_destroy")
        XCTAssertEqual(model.resourceType, "image")
        XCTAssertEqual(model.region,       "nyc3")
        XCTAssertEqual(model.startedAt,    Date(ISOString: "2016-09-30T19:52:21Z"))
        XCTAssertEqual(model.finishedAt,   Date(ISOString: "2016-09-30T19:52:21Z"))
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Action.self, name: "action")
    }
}
