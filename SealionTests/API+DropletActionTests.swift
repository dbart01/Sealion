//
//  API+DropletActionTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-11.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_DropletActionTests: APITestCase {

    func testActions() {
        let id     = 123
        let action = DropletAction.createSnapshot(name: "test")
        let handle = self.api.action(create: action, for: id) { result in }
        
        self.assertType(handle, type: Action.self)
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: action)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .dropletActionsWithID(id))
        self.assertKeyPath(handle, keyPath: "action")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testActionsForDoplet() {
        let id     = 123
        let handle = self.api.actionsFor(droplet: id) { result in }
        
        self.assertType(handle, type: [Action].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .dropletActionsWithID(id))
        self.assertKeyPath(handle, keyPath: "actions")
        self.assertParameters(handle, parameters: nil)
    }
}
