//
//  IdentifierTest.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-09.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class IdentifierTests: XCTestCase {
    
    // ----------------------------------
    //  MARK: - Json Creation -
    //
    func testIdentifierAsInteger() {
        let id:   Identifier = 123
        let json: JSON       = [
            "id" : id,
        ]
        
        XCTAssertEqual(json["id"] as! Int, 123)
    }
    
    func testIdentifierAsString() {
        let id:   Identifier = "123"
        let json: JSON       = [
            "id" : id,
        ]
        
        XCTAssertEqual(json["id"] as! String, "123")
    }
}
