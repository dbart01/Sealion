//
//  BackupWindowTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-08.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class BackupWindowTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: BackupWindow = self.modelNamed(name: "backupWindow")
        
        XCTAssertEqual(model.start, Date(ISOString: "2016-09-26T00:00:00Z"))
        XCTAssertEqual(model.end,   Date(ISOString: "2016-09-26T23:00:00Z"))
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: BackupWindow.self, name: "backupWindow")
    }
}
