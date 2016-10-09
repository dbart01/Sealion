//
//  API+KeyTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-09.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class API_KeyTests: APITestCase {
    
    func testKeyList() {
        let handle = self.api.sshKeys { result in }
        
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .sshKeys)
        self.assertKeyPath(handle, keyPath: "ssh_keys")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testKeyWithID() {
        let id     = 123
        let handle = self.api.sshKeyWith(id: 123) { result in }
        
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .sshKeyWithID(id))
        self.assertKeyPath(handle, keyPath: "ssh_key")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testKeyWithFingerprint() {
        let fingerprint = "f1:a2"
        let handle      = self.api.sshKeyWith(fingerprint: fingerprint) { result in }
        
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .sshKeyWithFingerprint(fingerprint))
        self.assertKeyPath(handle, keyPath: "ssh_key")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testKeyCreate() {
        let request = self.createRequest()
        let handle  = self.api.create(sshKey: request) { result in }
        
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .sshKeys)
        self.assertKeyPath(handle, keyPath: "ssh_key")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testKeyUpdateWithID() {
        let id      = 123
        let request = self.createRequest()
        let handle  = self.api.update(sshKey: id, request: request) { result in }
        
        self.assertMethod(handle, method: .put)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .sshKeyWithID(id))
        self.assertKeyPath(handle, keyPath: "ssh_key")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testKeyUpdateWithFingerprint() {
        let fingerprint = "f1:a2"
        let request     = self.createRequest()
        let handle      = self.api.update(sshKey: fingerprint, request: request) { result in }
        
        self.assertMethod(handle, method: .put)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .sshKeyWithFingerprint(fingerprint))
        self.assertKeyPath(handle, keyPath: "ssh_key")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testKeyDeleteWithID() {
        let id     = 123
        let handle = self.api.delete(sshKey: 123) { result in }
        
        self.assertMethod(handle, method: .delete)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .sshKeyWithID(id))
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: nil)
    }
    
    func testKeyDeleteWithFingerprint() {
        let fingerprint = "f1:a2"
        let handle      = self.api.delete(sshKey: fingerprint) { result in }
        
        self.assertMethod(handle, method: .delete)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .sshKeyWithFingerprint(fingerprint))
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: nil)
    }
    
    // ----------------------------------
    //  MARK: - Requests -
    //
    private func createRequest() -> Droplet.Key.CreateRequest {
        let name = "testKey"
        let key  = "ssh-rsa AAAAB123j3k12j"
        return Droplet.Key.CreateRequest(name: name, publicKey: key)
    }
}
