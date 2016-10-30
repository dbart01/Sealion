//
//  FloatingIPTests.swift
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

class FloatingIPTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreationWithDroplet() {
        let model:   FloatingIP = self.modelNamed(name: "floatingIPWithDroplet")
        let droplet: Droplet    = self.modelNamed(name: "droplet")
        let region:  Region     = self.modelNamed(name: "region")
        
        
        XCTAssertEqual(model.ip,      "12.12.12.12")
        XCTAssertEqual(model.droplet, droplet)
        XCTAssertEqual(model.region,  region)
    }
    
    func testJsonCreationWithoutDroplet() {
        let model:  FloatingIP = self.modelNamed(name: "floatingIPWithoutDroplet")
        let region: Region     = self.modelNamed(name: "region")
        
        
        XCTAssertEqual(model.ip,      "12.12.12.12")
        XCTAssertEqual(model.region,  region)
        XCTAssertEqual(model.droplet, nil)
    }
    
    func testEqualityWithDroplet() {
        self.assertEqualityForModelNamed(type: FloatingIP.self, name: "floatingIPWithDroplet")
    }
    
    func testEqualityWithoutDroplet() {
        self.assertEqualityForModelNamed(type: FloatingIP.self, name: "floatingIPWithoutDroplet")
    }
    
    // ----------------------------------
    //  MARK: - Create Request Droplet -
    //
    func testCreateRequestDroplet() {
        let id      = 123
        let request = FloatingIP.CreateRequestDroplet(droplet: id)
        
        let json = request.json
        
        XCTAssertEqual(json["droplet_id"] as! Int, id)
    }
    
    func testCreateRequestRegion() {
        let region  = "nyc3"
        let request = FloatingIP.CreateRequestRegion(region: region)
        
        let json = request.json
        
        XCTAssertEqual(json["region"] as! String, region)
    }
}
