//
//  SealionTests.swift
//  SealionTests
//
//  Created by Dima Bart on 2016-10-01.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class SealionTests: XCTestCase {
    
    func testExample() {
        let e = self.expectation(description: "")
        
        let api = API(version: .v2, token: "a4b2f1b7e1f10dab178375189f2a285a18abee5f4e353dcfedae7087e9e25463")
        api.account { (response: Response<Account>) in
            switch response {
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
