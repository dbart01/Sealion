//
//  VolumeTests.swift
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

class VolumeTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model:  Volume = self.modelNamed(name: "volume")
        let region: Region = self.modelNamed(name: "region")
        
        XCTAssertEqual(model.id,          "123")
        XCTAssertEqual(model.name,        "test")
        XCTAssertEqual(model.description, "test volume")
        XCTAssertEqual(model.size,        1)
        XCTAssertEqual(model.dropletIDs,  [123])
        XCTAssertEqual(model.region,      region)
        XCTAssertEqual(model.createdAt,   Date(ISOString: "2016-10-07T12:08:02Z"))
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Volume.self, name: "volume")
    }
    
    // ----------------------------------
    //  MARK: - Create Request -
    //
    func testCreateRequest() {
        let size        = 100
        let name        = "volume"
        let region      = "nyc3"
        let description = "A large volume"
        let request     = Volume.CreateRequest(size: size, name: name, region: region, description: description)
        
        let json = request.json
        
        XCTAssertEqual(json["size_gigabytes"] as! Int,    size)
        XCTAssertEqual(json["name"]           as! String, name)
        XCTAssertEqual(json["region"]         as! String, region)
        XCTAssertEqual(json["description"]    as! String, description)
    }
    
    // ----------------------------------
    //  MARK: - Snapshot Request -
    //
    func testSnapshotRequest() {
        let name    = "volume snapshot"
        let request = Volume.SnapshotRequest(name: name)
        
        let json = request.json
        
        XCTAssertEqual(json["name"] as! String, name)
    }
    
    // ----------------------------------
    //  MARK: - Name Request -
    //
    func testNameRequest() {
        let name    = "volume"
        let region  = "nyc3"
        let request = Volume.Name(name: name, region: region)
        
        let json = request.parameters
        
        XCTAssertEqual(json["name"],   name)
        XCTAssertEqual(json["region"], region)
    }
}
