//
//  API+SnapshotTests.swift
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

class API_SnapshotTests: APITestCase {
    
    func testSnapshotList() {
        let handle = self.api.snapshots { result in }
        
        self.assertType(handle, type: [Snapshot].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .snapshots)
        self.assertKeyPath(handle, keyPath: "snapshots")
        self.assertParameters(handle, parameters: nil)
        
        let handleWithParameters = self.api.snapshots(type: .droplet) { result in }
        
        self.assertParameters(handleWithParameters, parameters: [
            "resource_type" : "droplet"
        ])
    }
    
    func testSnapshotWithID() {
        let id     = 123
        let handle = self.api.snapshotWith(id: id) { result in }
        
        self.assertType(handle, type: Snapshot.self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .snapshotWithID(id))
        self.assertKeyPath(handle, keyPath: "snapshot")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testSnapshotsForDroplet() {
        let id     = 123
        let handle = self.api.snapshotsFor(droplet: id) { result in }
        
        self.assertType(handle, type: [Snapshot].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .snapshotsForDroplet(id))
        self.assertKeyPath(handle, keyPath: "snapshots")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testSnapshotsForVolume() {
        let id     = "123"
        let handle = self.api.snapshotsFor(volume: id) { result in }
        
        self.assertType(handle, type: [Snapshot].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .snapshotsForVolume(id))
        self.assertKeyPath(handle, keyPath: "snapshots")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testSnapshotsCreateForVolume() {
        let id      = "123"
        let name    = "volume-snapshot"
        let request = Volume.SnapshotRequest(name: name)
        let handle  = self.api.create(snapshot: request, for: id) { result in }
        
        self.assertType(handle, type: Snapshot.self)
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .snapshotsForVolume(id))
        self.assertKeyPath(handle, keyPath: "snapshot")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testSnapshotDelete() {
        let id     = 123
        let handle = self.api.delete(snapshot: 123) { result in }
        
        self.assertType(handle, type: Snapshot.self)
        self.assertMethod(handle, method: .delete)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .snapshotWithID(id))
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: nil)
    }
}
