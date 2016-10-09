//
//  ImageTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-08.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class ImageTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: Image = self.modelNamed(name: "image")
        
        XCTAssertEqual(model.id,             123)
        XCTAssertEqual(model.external,       false)
        XCTAssertEqual(model.name,           "some-image")
        XCTAssertEqual(model.type,           "snapshot")
        XCTAssertEqual(model.distribution,   "Ubuntu")
        XCTAssertEqual(model.slug,           "ubuntu")
        XCTAssertEqual(model.regionSlugs,    ["nyc3"])
        XCTAssertEqual(model.minimumDiskSize, 30.0)
        XCTAssertEqual(model.size,            3.62)
        XCTAssertEqual(model.createdAt,       Date(ISOString: "2015-08-07T19:44:51Z"))
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Image.self, name: "image")
    }
}
