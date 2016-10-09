//
//  API+DropletsTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-05.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

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
    
    func testDropletCreate() {
        let request = Droplet.CreateRequest(name: "test.example.com", region: "nyc3", size: "512mb", image: "ubuntu-14.04")
        let handle = self.api.create(droplet: request) { result in }
        
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .droplets)
        self.assertKeyPath(handle, keyPath: "droplet")
        self.assertParameters(handle, parameters: nil)
    }
}
