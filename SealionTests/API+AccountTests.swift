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
        let handle = self.api.account { result in }
        
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .account)
        self.assertKeyPath(handle, keyPath: "account")
        self.assertParameters(handle, parameters: nil)
    }
}
