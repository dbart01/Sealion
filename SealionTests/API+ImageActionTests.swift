//
//  API+ImageActionTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-15.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_ImageActionTests: APITestCase {
    
    func testActions() {
        let region = "nyc3"
        let id     = 123
        let action = ImageAction.transferTo(region: region)
        let handle = self.api.action(create: action, for: id) { result in }
        
        self.assertType(handle, type: Action.self)
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: action)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .imageActionsWithID(id))
        self.assertKeyPath(handle, keyPath: "action")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testActionsForImage() {
        let id     = 123
        let handle = self.api.actionsFor(image: id) { result in }
        
        self.assertType(handle, type: [Action].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .imageActionsWithID(id))
        self.assertKeyPath(handle, keyPath: "actions")
        self.assertParameters(handle, parameters: nil)
    }
}
