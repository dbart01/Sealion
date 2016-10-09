//
//  API+DropletsTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-05.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class API_DropletsTests: APITestCase {
    
    func testDropletList() {
        let handle = self.api.droplets { result in }
        
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .droplets)
        self.assertKeyPath(handle, keyPath: "droplets")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testDropletListByTag() {
        let tag    = "production"
        let handle = self.api.droplets(tag: tag) { result in }
        
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .droplets)
        self.assertKeyPath(handle, keyPath: "droplets")
        self.assertParameters(handle, parameters: ["tag_name" : tag])
    }
    
    func testDropletWithID() {
        let id     = 123
        let handle = self.api.dropletWith(id: 123) { result in }
        
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .dropletWithID(id))
        self.assertKeyPath(handle, keyPath: "droplet")
        self.assertParameters(handle, parameters: nil)
    }
}
