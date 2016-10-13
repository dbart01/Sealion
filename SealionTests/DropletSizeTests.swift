//
//  DropletSizeTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-08.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class DropletSizeTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: DropletSize = self.modelNamed(name: "size")
        
        XCTAssertEqual(model.slug,         "1gb")
        XCTAssertEqual(model.available,    true)
        XCTAssertEqual(model.memory,       1024)
        XCTAssertEqual(model.vcpus,        1)
        XCTAssertEqual(model.disk,         30)
        XCTAssertEqual(model.transfer,     2)
        XCTAssertEqual(model.priceMonthly, 10.0)
        XCTAssertEqual(model.priceHourly,  0.01488)
        XCTAssertEqual(model.regions,      ["nyc3", "tor1"])
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: DropletSize.self, name: "size")
    }
}
