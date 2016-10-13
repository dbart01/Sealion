//
//  API+FloatingIPActionTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_FloatingIPActionTests: APITestCase {
    
    func testActions() {
        let ip     = "12.12.12.12"
        let action = FloatingIPAction.assign(droplet: 123)
        let handle = self.api.action(create: action, for: ip) { result in }
        
        self.assertType(handle, type: Action.self)
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: action)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .floatingIPActionsWithIP(ip))
        self.assertKeyPath(handle, keyPath: "action")
        self.assertParameters(handle, parameters: nil)
    }
}
