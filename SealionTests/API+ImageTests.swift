//
//  API+ImageTests.swift
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
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: nil)
    }
}
