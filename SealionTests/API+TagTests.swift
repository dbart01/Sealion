//
//  API+TagTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_TagTests: APITestCase {
    
    func testTagList() {
        let handle = self.api.tags { result in }
        
        self.assertType(handle, type: [Tag].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .tags)
        self.assertKeyPath(handle, keyPath: "tags")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testTagWithName() {
        let name   = "cool"
        let handle = self.api.tagWith(name: name) { result in }
        
        self.assertType(handle, type: Tag.self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .tagWithName(name))
        self.assertKeyPath(handle, keyPath: "tag")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testTagCreate() {
        let request = Tag.CreateRequest(name: "cool")
        let handle  = self.api.create(tag: request) { result in }
        
        self.assertType(handle, type: Tag.self)
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .tags)
        self.assertKeyPath(handle, keyPath: "tag")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testTagUpdate() {
        let name    = "cool"
        let request = Tag.CreateRequest(name: "awesome")
        let handle  = self.api.update(tag: name, request: request) { result in }
        
        self.assertType(handle, type: Tag.self)
        self.assertMethod(handle, method: .put)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .tagWithName(name))
        self.assertKeyPath(handle, keyPath: "tag")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testTagDelete() {
        let name   = "cool"
        let handle = self.api.delete(tag: name) { result in }
        
        self.assertType(handle, type: Tag.self)
        self.assertMethod(handle, method: .delete)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .tagWithName(name))
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: nil)
    }
    
    func testAssignTag() {
        let request = Tag.TagRequest(resources: [
            Tag.TagRequest.Resource(type: .droplet, id: 123),
            Tag.TagRequest.Resource(type: .droplet, id: 234),
        ])
        
        let name   = "cool"
        let handle = self.api.assign(tag: name, request: request) { result in }
        
        self.assertType(handle, type: Tag.self)
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .tagWithName(name))
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: nil)
    }
    
    func testUnassignTag() {
        let request = Tag.TagRequest(resources: [
            Tag.TagRequest.Resource(type: .droplet, id: 123),
            Tag.TagRequest.Resource(type: .droplet, id: 234),
        ])
        
        let name   = "cool"
        let handle = self.api.unassign(tag: name, request: request) { result in }
        
        self.assertType(handle, type: Tag.self)
        self.assertMethod(handle, method: .delete)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .tagWithName(name))
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: nil)
    }
}
