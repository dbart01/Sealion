//
//  API+VolumesTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class API_VolumesTests: APITestCase {
    
    func testVolumesList() {
        let handle = self.api.volumes { result in }
        
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .volumes)
        self.assertKeyPath(handle, keyPath: "volumes")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testVolumeWithID() {
        let id     = "123"
        let handle = self.api.volumeWith(id: id) { result in }
        
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .volumeWithID(id))
        self.assertKeyPath(handle, keyPath: "volume")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testVolumeWithName() {
        let name   = Volume.Name(name: "test", region: "nyc1")
        let handle = self.api.volumeWith(name: name) { result in }
        
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .volumes)
        self.assertKeyPath(handle, keyPath: "volumes")
        self.assertParameters(handle, parameters: name)
    }
    
    func testVolumeCreate() {
        let volume = Volume.CreateRequest(size: 1, name: "test", regionSlug: "nyc1", description: "Test volume created from tests.")
        let handle = self.api.create(volume: volume) { result in }
        
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: volume)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .volumes)
        self.assertKeyPath(handle, keyPath: "volumes")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testVolumeDeleteByID() {
        let id     = "123"
        let handle = self.api.delete(volume: id) { result in }
        
        self.assertMethod(handle, method: .delete)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .volumeWithID(id))
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: nil)
    }
    
    func testVolumeDeleteByName() {
        let name   = Volume.Name(name: "test", region: "nyc1")
        let handle = self.api.delete(volume: name) { result in }
        
        self.assertMethod(handle, method: .delete)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .volumes)
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: name)
    }
}
