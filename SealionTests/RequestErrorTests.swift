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
        let errorJSON = self.jsonManager.modelJsonFor(key: "error")
        let error     = RequestError(json: errorJSON)
        
        XCTAssertEqual(error.id,          "request_id")
        XCTAssertEqual(error.name,        "error_id")
        XCTAssertEqual(error.description, "Error message")
    }
    
    func testEquality() {
        let model1 = RequestError(json: self.jsonManager.modelJsonFor(key: "error"))
        let model2 = RequestError(id: model1.id, name: model1.name, description: model1.description)
        
        XCTAssertEqual(model1, model2)
    }
}
