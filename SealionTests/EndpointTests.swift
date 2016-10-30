//
//  EndpointTests.swift
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

class EndpointTests: XCTest {
    
    func testEndpoints() {
        XCTAssertEqual(Endpoint.account.path,                                "account")
        XCTAssertEqual(Endpoint.actions.path,                                "actions")
        XCTAssertEqual(Endpoint.actionWithID(123).path,                      "actions/123")
        XCTAssertEqual(Endpoint.volumes.path,                                "volumes")
        XCTAssertEqual(Endpoint.volumeWithID("123").path,                    "volumes/123")
        XCTAssertEqual(Endpoint.volumeActions.path,                          "volumes/actions")
        XCTAssertEqual(Endpoint.volumeActionsWithID("123").path,             "volumes/123/actions")
        XCTAssertEqual(Endpoint.snapshotsForVolume("123").path,              "volumes/123/snapshots")
        XCTAssertEqual(Endpoint.domains.path,                                "domains")
        XCTAssertEqual(Endpoint.domainWithName("example.com").path,          "domains/example.com")
        XCTAssertEqual(Endpoint.recordsForDomain("example").path,            "domains/example.com/records")
        XCTAssertEqual(Endpoint.recordForDomain("example", 123).path,        "domains/example.com/records/123")
        XCTAssertEqual(Endpoint.droplets.path,                               "droplets")
        XCTAssertEqual(Endpoint.dropletWithID(123).path,                     "droplets/123")
        XCTAssertEqual(Endpoint.dropletActionsWithID(123).path,              "droplets/123/actions")
        XCTAssertEqual(Endpoint.kernelsForDroplet(123).path,                 "droplets/123/kernels")
        XCTAssertEqual(Endpoint.snapshotsForDroplet(123).path,               "droplets/123/snapshots")
        XCTAssertEqual(Endpoint.backupsForDroplet(123).path,                 "droplets/123/backups")
        XCTAssertEqual(Endpoint.neighborsForDroplet(123).path,               "droplets/123/neighbors")
        XCTAssertEqual(Endpoint.neighbors.path,                              "reports/droplet_neighbors")
        XCTAssertEqual(Endpoint.images.path,                                 "images")
        XCTAssertEqual(Endpoint.imageWithID(123).path,                       "images/123")
        XCTAssertEqual(Endpoint.imageWithSlug("acb").path,                   "images/abc")
        XCTAssertEqual(Endpoint.imageActionsWithID(123).path,                "images/123/actions")
        XCTAssertEqual(Endpoint.snapshots.path,                              "snapshots")
        XCTAssertEqual(Endpoint.snapshotWithID(123).path,                    "snapshots/123")
        XCTAssertEqual(Endpoint.sshKeys.path,                                "account/keys")
        XCTAssertEqual(Endpoint.sshKeyWithID(123).path,                      "account/keys/123")
        XCTAssertEqual(Endpoint.sshKeyWithFingerprint("a1b2c3").path,        "account/keys/a1b2c3")
        XCTAssertEqual(Endpoint.regions.path,                                "regions")
        XCTAssertEqual(Endpoint.sizes.path,                                  "sizes")
        XCTAssertEqual(Endpoint.floatingIPs.path,                            "floating_ips")
        XCTAssertEqual(Endpoint.floatingIPWithIP("12.12.12.12").path,        "floating_ips/12.12.12.12")
        XCTAssertEqual(Endpoint.floatingIPActionsWithIP("12.12.12.12").path, "floating_ips/12.12.12.12/actions")
        XCTAssertEqual(Endpoint.tags.path,                                   "tags")
        XCTAssertEqual(Endpoint.tagWithName("cool").path,                    "tags/cool")
    }
}
