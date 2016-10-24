//
//  RequestErrorTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-05.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class RequestErrorTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: RequestError = self.modelNamed(name: "error")
        
        XCTAssertEqual(model.code,        403)
        XCTAssertEqual(model.id,          "request_id")
        XCTAssertEqual(model.name,        "error_id")
        XCTAssertEqual(model.description, "Error message")
    }
    
    func testDefaultCreation() {
        let id          = "request_id"
        let name        = "error_id"
        let description = "Error message"
        
        let error = RequestError(
            code:        400,
            id:          id,
            name:        name,
            description: description
        )

        XCTAssertEqual(error.code,        400)
        XCTAssertEqual(error.id,          id)
        XCTAssertEqual(error.name,        name)
        XCTAssertEqual(error.description, description)
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: RequestError.self, name: "error")
    }
}
