//
//  EndpointTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-15.
//  Copyright © 2016 Dima Bart. All rights reserved.
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
        XCTAssertEqual(Endpoint.volumeActionsWithID(123).path,               "volumes/123/actions")
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
