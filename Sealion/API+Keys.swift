//
//  API+Keys.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-09.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func sshKeys(completion: @escaping (_ result: Result<[Droplet.Key]>) -> Void) -> Handle<[Droplet.Key]> {
        let request = self.requestTo(endpoint: .sshKeys, method: .get)
        return self.taskWith(request: request, keyPath: "ssh_keys", completion: completion)
    }
    
    public func sshKeyWith(id: Int, completion: @escaping (_ result: Result<Droplet.Key>) -> Void) -> Handle<Droplet.Key> {
        let request = self.requestTo(endpoint: .sshKeyWithID(id), method: .get)
        return self.taskWith(request: request, keyPath: "ssh_key", completion: completion)
    }
    
    public func sshKeyWith(fingerprint: String, completion: @escaping (_ result: Result<Droplet.Key>) -> Void) -> Handle<Droplet.Key> {
        let request = self.requestTo(endpoint: .sshKeyWithFingerprint(fingerprint), method: .get)
        return self.taskWith(request: request, keyPath: "ssh_key", completion: completion)
    }
    
    public func create(sshKey: Droplet.Key.CreateRequest, completion: @escaping (_ result: Result<Droplet.Key>) -> Void) -> Handle<Droplet.Key> {
        let request = self.requestTo(endpoint: .sshKeys, method: .post, payload: sshKey)
        return self.taskWith(request: request, keyPath: "ssh_key", completion: completion)
    }
    
    public func update(sshKey id: Int, request: Droplet.Key.CreateRequest, completion: @escaping (_ result: Result<Droplet.Key>) -> Void) -> Handle<Droplet.Key> {
        let request = self.requestTo(endpoint: .sshKeyWithID(id), method: .put, payload: request)
        return self.taskWith(request: request, keyPath: "ssh_key", completion: completion)
    }
    
    public func update(sshKey fingerprint: String, request: Droplet.Key.CreateRequest, completion: @escaping (_ result: Result<Droplet.Key>) -> Void) -> Handle<Droplet.Key> {
        let request = self.requestTo(endpoint: .sshKeyWithFingerprint(fingerprint), method: .put, payload: request)
        return self.taskWith(request: request, keyPath: "ssh_key", completion: completion)
    }
    
    public func delete(sshKey id: Int, completion: @escaping (_ result: Result<Droplet.Key>) -> Void) -> Handle<Droplet.Key> {
        let request = self.requestTo(endpoint: .sshKeyWithID(id), method: .delete)
        return self.taskWith(request: request, completion: completion)
    }
    
    public func delete(sshKey fingerprint: String, completion: @escaping (_ result: Result<Droplet.Key>) -> Void) -> Handle<Droplet.Key> {
        let request = self.requestTo(endpoint: .sshKeyWithFingerprint(fingerprint), method: .delete)
        return self.taskWith(request: request, completion: completion)
    }
}
