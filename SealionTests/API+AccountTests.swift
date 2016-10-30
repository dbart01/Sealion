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
    
    func testSample() {
        let e = self.expectation(description: "")
        
        self.api.account { result in
            switch result {
            case .success(let account):
                print("Account: \(account!)")
            case .failure(let message):
                print("Failure: \(message)")
            }
            
            e.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
}
