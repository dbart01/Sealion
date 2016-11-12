//
//  API+DropletTests.swift
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

class API_DropletTests: APITestCase {
    
    func testDropletList() {
        let handle = self.api.droplets { result in }
        
        self.assertType(handle, type: [Droplet].self)
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
        
        self.assertType(handle, type: [Droplet].self)
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
        
        self.assertType(handle, type: Droplet.self)
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
        
        self.assertType(handle, type: Droplet.self)
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .droplets)
        self.assertKeyPath(handle, keyPath: "droplet")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testDropletCreateMultiple() {
        let request = Droplet.CreateRequest(names: ["test1", "test2"], region: "nyc3", size: "512mb", image: "ubuntu-14.04")
        let handle = self.api.create(droplets: request) { result in }
        
        self.assertType(handle, type: [Droplet].self)
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .droplets)
        self.assertKeyPath(handle, keyPath: "droplets")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testDropletDeleteByID() {
        let id     = 123
        let handle = self.api.delete(droplet: id) { result in }
        
        self.assertType(handle, type: Droplet.self)
        self.assertMethod(handle, method: .delete)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .dropletWithID(id))
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: nil)
    }
    
    func testDropletDeleteByTag() {
        let tag    = "production"
        let handle = self.api.delete(droplets: tag) { result in }
        
        self.assertType(handle, type: Droplet.self)
        self.assertMethod(handle, method: .delete)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .droplets)
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: ["tag_name" : tag])
    }
}
