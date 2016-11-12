//
//  API+TagTests.swift
//  Sealion
//
//  Copyright (c) 2016 Dima Bart
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//  either expressed or implied, of the FreeBSD Project.
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
