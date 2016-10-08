//
//  DateFormatterTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-08.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class DateFormatterTests: XCTestCase {
    
    let validDateString   = "2016-10-07T12:08:02Z"
    let invalidDateString = "2016-Jul-07-12:08:02"
    
    let validDate = Date(timeIntervalSince1970: 1475842082)
    
    // ----------------------------------
    //  MARK: - String to Date -
    //
    func testValidStringToDate() {
        let date = Date(ISOString: self.validDateString)
        
        XCTAssertNotNil(date)
        XCTAssertEqual(date, self.validDate)
    }
    
    func testInvalidStringToDate() {
        let date = Date(ISOString: self.invalidDateString)
        XCTAssertNil(date)
    }
    
    // ----------------------------------
    //  MARK: - Date to String -
    //
    func testValidDateToString() {
        let dateString = self.validDate.ISOString
        XCTAssertEqual(dateString, self.validDateString)
    }
}
