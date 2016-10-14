//
//  VolumeActionTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-14.
//  Copyright © 2016 Dima Bart. All rights reserved.
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
