//
//  APITestCase.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-03.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class APITestCase: XCTestCase {
    
    let session  = MockSession(stubsNamed: "mocks")
    let queue    = OperationQueue()
    
    lazy private(set) var api: API = {
        return API(version: .v2, token: "a4b2f1b7e1f10dab178375189f2a285a18abee5f4e353dcfedae7087e9e25463", session: self.session, queue: self.queue)
    }()
}
