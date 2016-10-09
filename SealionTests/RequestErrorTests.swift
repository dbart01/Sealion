//
//  RequestErrorTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-05.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class RequestErrorTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: RequestError = self.modelNamed(name: "error")
        
        XCTAssertEqual(model.id,          "request_id")
        XCTAssertEqual(model.name,        "error_id")
        XCTAssertEqual(model.description, "Error message")
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: RequestError.self, name: "error")
    }
}
