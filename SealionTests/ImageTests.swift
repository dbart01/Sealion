//
//  ImageTests.swift
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

class ImageTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: Image = self.modelNamed(name: "image")
        
        XCTAssertEqual(model.id,             123)
        XCTAssertEqual(model.external,       false)
        XCTAssertEqual(model.name,           "some-image")
        XCTAssertEqual(model.type,           "snapshot")
        XCTAssertEqual(model.distribution,   "Ubuntu")
        XCTAssertEqual(model.slug,           "ubuntu")
        XCTAssertEqual(model.regionSlugs,    ["nyc3"])
        XCTAssertEqual(model.minimumDiskSize, 30.0)
        XCTAssertEqual(model.size,            3.62)
        XCTAssertEqual(model.createdAt,       Date(ISOString: "2015-08-07T19:44:51Z"))
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Image.self, name: "image")
    }
    
    // ----------------------------------
    //  MARK: - ImageType -
    //
    func testImageTypes() {
        
        let userType = Image.ImageType.user
        XCTAssertTrue(userType.parameters == [
            "private" : "true"
        ])
        
        let applicationType = Image.ImageType.application
        XCTAssertTrue(applicationType.parameters == [
            "type" : "application"
        ])
        
        let distributionType = Image.ImageType.distribution
        XCTAssertTrue(distributionType.parameters == [
            "type" : "distribution"
        ])
    }
    
    // ----------------------------------
    //  MARK: - UpdateRequest -
    //
    func testUpdateRequest() {
        let name    = "Snapshot Name"
        let request = Image.UpdateRequest(name: name)
        
        let json = request.json
        
        XCTAssertEqual(json["name"] as! String, name)
    }
}
