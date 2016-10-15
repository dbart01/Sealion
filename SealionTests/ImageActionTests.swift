//
//  ImageActionTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-15.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class ImageActionTests: XCTestCase {
    
    func testTrasfer() {
        self.assertImageAction(action: .transferTo(region: "nyc3"), against: [
            "type"   : "transfer",
            "region" : "nyc3",
        ])
    }
    
    func testEnableBackups() {
        self.assertImageAction(action: .convert, against: [
            "type" : "convert",
        ])
    }
    
    // ----------------------------------
    //  MARK: - Private -
    //
    private func assertImageAction(action: ImageAction, against expectation: Any) {
        XCTAssertTrue(action.json == expectation as! JSON)
    }
}
