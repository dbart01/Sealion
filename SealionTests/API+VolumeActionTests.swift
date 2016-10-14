//
//  API+VolumeActionTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-14.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_VolumeActionTests: APITestCase {
    
    func testAnonymousActions() {
        let volume  = "some-volume"
        let droplet = 123
        let region  = "nyc3"
        
        let action  = VolumeAction.attach(volume: volume, droplet: droplet, region: region)
        let handle  = self.api.action(create: action) { result in }
        
        self.assertType(handle, type: Action.self)
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: action)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .volumeActions)
        self.assertKeyPath(handle, keyPath: "action")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testActions() {
        
        let id      = 123
        let droplet = 234
        let region  = "nyc3"
        
        let action  = VolumeAction.attachTo(droplet: droplet, region: region)
        let handle  = self.api.action(create: action, for: id) { result in }
        
        self.assertType(handle, type: Action.self)
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: action)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .volumeActionsWithID(id))
        self.assertKeyPath(handle, keyPath: "action")
        self.assertParameters(handle, parameters: nil)
    }
}
