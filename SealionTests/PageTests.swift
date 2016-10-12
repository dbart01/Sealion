//
//  PageTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-11.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class PageTests: XCTestCase {
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testInitWithDefault() {
        let page = Page()
        
        XCTAssertEqual(page.index, 0)
        XCTAssertEqual(page.count, 200)
    }
    
    func testInitWithCustom() {
        let page = Page(index: 4, count: 20)
        
        XCTAssertEqual(page.index, 4)
        XCTAssertEqual(page.count, 20)
    }
    
    // ----------------------------------
    //  MARK: - ParameterConvertible -
    //
    func testConversion() {
        let page       = Page(index: 3, count: 50)
        let serialized = page.parameters
        
        let parameters = [
            "page"     : "4",
            "per_page" : "50",
        ]
        
        XCTAssertTrue(serialized == parameters)
    }
}
