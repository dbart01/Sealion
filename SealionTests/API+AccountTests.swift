//
//  API+AccountTests.swift
//  SealionTests
//
//  Created by Dima Bart on 2016-10-01.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class API_AccountTests: APITestCase {
    
    func testAccount() {
        self.mockUsing(name: "account")
        let e = self.expectation(description: "")
        
        self.api.account { result in
            
            if case .success(let account) = result {
                guard let account = account else {
                    XCTFail("Expecting a non-nil account.")
                    return
                }
                
                XCTAssertEqual(account.floatingIPLimit, 3)
                XCTAssertEqual(account.dropletLimit,    25)
                XCTAssertEqual(account.status,          "active")
                XCTAssertEqual(account.uuid,            "b9831c92486271c9797ef5h77e234f882d7a3fc2")
                XCTAssertEqual(account.email,           "john.smith@gmail.com")
                XCTAssertEqual(account.message,         "")
                XCTAssertEqual(account.verified,        true)
                
            } else {
                XCTFail("Expecting a successful request.")
            }
            
            e.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        self.clearMock()
    }
}
