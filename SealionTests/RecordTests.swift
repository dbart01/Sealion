//
//  RecordTests.swift
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

class RecordTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: Record = self.modelNamed(name: "record")
        
        XCTAssertEqual(model.id,       123)
        XCTAssertEqual(model.kind,     Record.Kind(rawValue: "MX")!)
        XCTAssertEqual(model.name,     "@")
        XCTAssertEqual(model.value,    "mail.example.com")
        XCTAssertEqual(model.priority, 1)
        XCTAssertEqual(model.port,     80)
        XCTAssertEqual(model.weight,   10)
    }
    
    func testJsonCreationWithNullValues() {
        let model: Record = self.modelNamed(name: "recordWithNull")
        
        XCTAssertEqual(model.id,       123)
        XCTAssertEqual(model.kind,     Record.Kind(rawValue: "A")!)
        XCTAssertEqual(model.name,     "@")
        XCTAssertEqual(model.value,    "example.com")
        XCTAssertEqual(model.priority, nil)
        XCTAssertEqual(model.port,     nil)
        XCTAssertEqual(model.weight,   nil)
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Record.self, name: "record")
    }
    
    // ----------------------------------
    //  MARK: - Create Request -
    //
    func testCreateRequest() {
        let kind    = Record.Kind.a
        let name    = "@"
        let value   = "12.12.12.12"
        var request = Record.CreateRequest(kind: .a, name: name, value: value)
        
        var json    = request.json
        
        XCTAssertEqual(json["type"] as! String, kind.rawValue)
        XCTAssertEqual(json["name"] as! String, name)
        XCTAssertEqual(json["data"] as! String, value)
        
        XCTAssertNil(json["priority"])
        XCTAssertNil(json["port"])
        XCTAssertNil(json["weight"])
        
        let priority     = 10
        request.priority = priority
        json = request.json
        XCTAssertEqual(json["priority"] as! Int, priority)
        
        let port     = 80
        request.port = port
        json = request.json
        XCTAssertEqual(json["port"] as! Int, port)
        
        let weight     = 5
        request.weight = weight
        json = request.json
        XCTAssertEqual(json["weight"] as! Int, weight)
    }
    
    // ----------------------------------
    //  MARK: - Update Request -
    //
    func testUpdateRequest() {
        var request = Record.UpdateRequest()
        var json    = request.json
        
        XCTAssertNil(json["type"])
        XCTAssertNil(json["name"])
        XCTAssertNil(json["data"])
        XCTAssertNil(json["priority"])
        XCTAssertNil(json["port"])
        XCTAssertNil(json["weight"])
        
        let kind     = Record.Kind.a
        request.kind = kind
        json = request.json
        XCTAssertEqual(json["type"] as! String, kind.rawValue)
        
        let name     = "@"
        request.name = name
        json = request.json
        XCTAssertEqual(json["name"] as! String, name)
        
        let value     = "12.12.12.12"
        request.value = value
        json = request.json
        XCTAssertEqual(json["data"] as! String, value)
        
        let priority     = 10
        request.priority = priority
        json = request.json
        XCTAssertEqual(json["priority"] as! Int, priority)
        
        let port     = 80
        request.port = port
        json = request.json
        XCTAssertEqual(json["port"] as! Int, port)
        
        let weight     = 5
        request.weight = weight
        json = request.json
        XCTAssertEqual(json["weight"] as! Int, weight)
    }
}
