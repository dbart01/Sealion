//
//  VolumeActionTests.swift
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

class VolumeActionTests: XCTestCase {
  
    func testAttachTo() {
        let droplet = 123
        let region  = "nyc3"
        
        self.assertVolumeAction(action: .attachTo(droplet: droplet, region: region), against: [
            "type"       : "attach",
            "droplet_id" : droplet,
            "region"     : region,
        ])
    }
    
    func testAttach() {
        let volume  = "some-volume"
        let droplet = 123
        let region  = "nyc3"
        
        self.assertVolumeAction(action: .attach(volume: volume, droplet: droplet, region: region), against: [
            "type"        : "attach",
            "volume_name" : volume,
            "droplet_id"  : droplet,
            "region"      : region,
        ])
    }
    
    func testDetachFrom() {
        let droplet = 123
        let region  = "nyc3"
        
        self.assertVolumeAction(action: .detachFrom(droplet: droplet, region: region), against: [
            "type"        : "detach",
            "droplet_id"  : droplet,
            "region"      : region,
        ])
    }
    
    func testDetach() {
        let volume  = "some-volume"
        let droplet = 123
        let region  = "nyc3"
        
        self.assertVolumeAction(action: .detach(volume: volume, droplet: droplet, region: region), against: [
            "type"        : "detach",
            "volume_name" : volume,
            "droplet_id"  : droplet,
            "region"      : region,
        ])
    }
    
    func testResize() {
        let size   = 125
        let region = "nyc3"
        
        self.assertVolumeAction(action: .resize(GB: size, region: region), against: [
            "type"           : "resize",
            "size_gigabytes" : size,
            "region"         : region,
        ])
    }
    
    // ----------------------------------
    //  MARK: - Private -
    //
    private func assertVolumeAction(action: VolumeAction, against expectation: Any) {
        XCTAssertTrue(action.json == expectation as! JSON)
    }
}
