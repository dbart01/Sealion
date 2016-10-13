//
//  FloatingIPActionTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class FloatingIPActionTests: XCTestCase {
    
    func testPasswordReset() {
        self.assertFloatingIPAction(action: .assign(droplet: 123), against: [
            "type"       : "assign",
            "droplet_id" : 123,
        ])
    }
    
    func testEnableBackups() {
        self.assertFloatingIPAction(action: .unassign, against: [
            "type" : "unassign",
        ])
    }
    
    // ----------------------------------
    //  MARK: - Private -
    //
    private func assertFloatingIPAction(action: FloatingIPAction, against expectation: Any) {
        XCTAssertTrue(action.json == expectation as! JSON)
    }
}
