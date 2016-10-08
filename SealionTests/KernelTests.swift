//
//  KernelTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-08.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class KernelTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: Kernel = self.modelNamed(name: "kernel")
        
        XCTAssertEqual(model.id,      123)
        XCTAssertEqual(model.name,    "Ubuntu")
        XCTAssertEqual(model.version, "generic")
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Kernel.self, name: "kernel")
    }
}
