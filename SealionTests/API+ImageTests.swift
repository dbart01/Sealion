//
//  API+ImageTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-12.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_ImageTests: APITestCase {
    
    func testImageList() {
        let handle = self.api.images { result in }
        
        self.assertType(handle, type: [Image].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .images)
        self.assertKeyPath(handle, keyPath: "images")
        self.assertParameters(handle, parameters: nil)
        
        let handleWithParameters = self.api.images(type: .user) { result in }
        
        self.assertParameters(handleWithParameters, parameters: [
            "private" : "true"
        ])
    }
    
    func testImageWithID() {
        let id     = 123
        let handle = self.api.imageWith(id: id) { result in }
        
        self.assertType(handle, type: Image.self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .imageWithID(id))
        self.assertKeyPath(handle, keyPath: "image")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testImageWithSlug() {
        let slug   = "ubuntu-14.04"
        let handle = self.api.imageWith(slug: slug) { result in }
        
        self.assertType(handle, type: Image.self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .imageWithSlug(slug))
        self.assertKeyPath(handle, keyPath: "image")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testImageUpdate() {
        let id      = 123
        let request = Image.UpdateRequest(name: "new-name")
        let handle  = self.api.update(image: 123, request: request) { result in }
        
        self.assertType(handle, type: Image.self)
        self.assertMethod(handle, method: .put)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .imageWithID(id))
        self.assertKeyPath(handle, keyPath: "image")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testImageDelete() {
        let id     = 123
        let handle = self.api.delete(image: 123) { result in }
        
        self.assertType(handle, type: Image.self)
        self.assertMethod(handle, method: .delete)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .imageWithID(id))
        self.assertKeyPath(handle, keyPath: "image")
        self.assertParameters(handle, parameters: nil)
    }
}
