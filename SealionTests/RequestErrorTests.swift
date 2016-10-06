//
//  RequestErrorTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-05.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class RequestErrorTests: XCTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let errorJSON = JsonManager(jsonNamed: "models").modelJsonFor(key: "error")
        let error     = RequestError(json: errorJSON)
        
        XCTAssertEqual(error.id,          "request_id")
        XCTAssertEqual(error.name,        "error_id")
        XCTAssertEqual(error.description, "Error message")
    }
}
