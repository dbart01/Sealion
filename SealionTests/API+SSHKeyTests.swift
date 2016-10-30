//
//  API+SSHKeyTests.swift
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

class API_SSHKeyTests: APITestCase {
    
    func testKeyList() {
        let handle = self.api.sshKeys { result in }
        
        self.assertType(handle, type: [SSHKey].self)
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
        
        self.assertType(handle, type: SSHKey.self)
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
        
        self.assertType(handle, type: SSHKey.self)
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
        
        self.assertType(handle, type: SSHKey.self)
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
        
        self.assertType(handle, type: SSHKey.self)
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
        
        self.assertType(handle, type: SSHKey.self)
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
        
        self.assertType(handle, type: SSHKey.self)
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
    private func createRequest() -> SSHKey.CreateRequest {
        let name = "testKey"
        let key  = "ssh-rsa AAAAB123j3k12j"
        return SSHKey.CreateRequest(name: name, publicKey: key)
    }
}
