//
//  ParameterConvertibleTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-10.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class ParameterConvertibleTests: XCTestCase {
    
    // ----------------------------------
    //  MARK: - Combinations -
    //
    func testCombination() {
        let parameters1: Parameters = [
            "id"   : "123",
            "name" : "test",
        ]
        
        let parameters2: Parameters = [
            "page"     : "1",
            "per_page" : "20",
        ]
        
        let result = parameters1.combineWith(convertible: parameters2).parameters
        
        XCTAssertEqual(result["id"],       "123")
        XCTAssertEqual(result["name"],     "test")
        XCTAssertEqual(result["page"],     "1")
        XCTAssertEqual(result["per_page"], "20")
    }
}
