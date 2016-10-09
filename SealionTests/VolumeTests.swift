//
//  VolumeTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-07.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class VolumeTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model:  Volume = self.modelNamed(name: "volume")
        let region: Region = self.modelNamed(name: "region")
        
        XCTAssertEqual(model.id,          "123")
        XCTAssertEqual(model.name,        "test")
        XCTAssertEqual(model.description, "test volume")
        XCTAssertEqual(model.size,        1)
        XCTAssertEqual(model.dropletIDs,  [123])
        XCTAssertEqual(model.region,      region)
        XCTAssertEqual(model.createdAt,   Date(ISOString: "2016-10-07T12:08:02Z"))
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Volume.self, name: "volume")
    }
}
