//
//  API+ActionsTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-03.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_ActionsTests: APITestCase {
    
    func testActionsList() {
        let handle = self.api.actions { result in }
        
        self.assertType(handle, type: [Action].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .actions)
        self.assertKeyPath(handle, keyPath: "actions")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testActionWithID() {
        let id     = 123
        let handle = self.api.actionWith(id: id) { result in }
        
        self.assertType(handle, type: Action.self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .actionWithID(id))
        self.assertKeyPath(handle, keyPath: "action")
        self.assertParameters(handle, parameters: nil)
    }
}
