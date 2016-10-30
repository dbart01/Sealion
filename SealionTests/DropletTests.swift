//
//  DropletTests.swift
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

class DropletTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model:     Droplet      = self.modelNamed(name: "dropletCreated")
        let image:     Image        = self.modelNamed(name: "image")
        let size:      DropletSize  = self.modelNamed(name: "size")
        let region:    Region       = self.modelNamed(name: "region")
        let v4Network: Network      = self.modelNamed(name: "v4Network")
        let v6Network: Network      = self.modelNamed(name: "v6Network")
        
        XCTAssertEqual(model.id,          123)
        XCTAssertEqual(model.name,        "some.droplet.com")
        XCTAssertEqual(model.locked,      false)
        XCTAssertEqual(model.status,      .active)
        XCTAssertEqual(model.features,    ["virtio"])
        XCTAssertEqual(model.tags,        ["awesome"])
        XCTAssertEqual(model.backupIDs,   [123, 234])
        XCTAssertEqual(model.snapshotIDs, [345, 456])
        XCTAssertEqual(model.volumeIDs,   [567, 678])
        XCTAssertEqual(model.createdAt,   Date(ISOString: "2015-08-07T19:50:26Z"))
        
        XCTAssertEqual(model.kernel,     nil)
        XCTAssertEqual(model.nextWindow, nil)
        XCTAssertEqual(model.image,      image)
        XCTAssertEqual(model.size,       size)
        XCTAssertEqual(model.region,     region)
        XCTAssertEqual(model.v4Networks, [v4Network])
        XCTAssertEqual(model.v6Networks, [v6Network])
        
        let model2: Droplet      = self.modelNamed(name: "droplet")
        let kernel: Kernel       = self.modelNamed(name: "kernel")
        let window: BackupWindow = self.modelNamed(name: "backupWindow")
        
        XCTAssertEqual(model2.kernel,     kernel)
        XCTAssertEqual(model2.nextWindow, window)
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Droplet.self, name: "dropletCreated")
        self.assertEqualityForModelNamed(type: Droplet.self, name: "droplet")
    }
    
    // ----------------------------------
    //  MARK: - CreateRequest -
    //
    func testCreateRequestWithImageID() {
        let name    = "test"
        let region  = "nyc3"
        let size    = "512mb"
        let image   = 123
        var request = Droplet.CreateRequest(
            name:   name,
            region: region,
            size:   size,
            image:  image
        )
        
        var json = request.json
        
        XCTAssertEqual(json["name"]   as! String, name)
        XCTAssertEqual(json["region"] as! String, region)
        XCTAssertEqual(json["size"]   as! String, size)
        XCTAssertEqual(json["image"]  as! Int,    image)
        
        XCTAssertNil(json["ssh_keys"])
        XCTAssertNil(json["backups"])
        XCTAssertNil(json["ipv6"])
        XCTAssertNil(json["private_networking"])
        XCTAssertNil(json["user_data"])
        XCTAssertNil(json["volume"])
        
        let names     = ["test1", "test2"]
        request.names = names
        json = request.json
        XCTAssertEqual(json["name"] as! [String], names)
        
        let sshKeys     = [123, 234]
        request.sshKeys = sshKeys
        json = request.json
        XCTAssertEqual(json["ssh_keys"] as! [Int], sshKeys)
        
        request.useBackups = true
        json = request.json
        XCTAssertTrue(json["backups"] as! Bool)
        
        request.useIpv6 = true
        json = request.json
        XCTAssertTrue(json["ipv6"] as! Bool)
        
        request.usePrivateNetworking = true
        json = request.json
        XCTAssertTrue(json["private_networking"] as! Bool)
        
        let userData     = "Some user data"
        request.userData = userData
        json = request.json
        XCTAssertEqual(json["user_data"] as! String, userData)
        
        let volumes     = ["123", "234"]
        request.volumes = volumes
        json = request.json
        XCTAssertEqual(json["volumes"] as! [String], volumes)
    }
}
