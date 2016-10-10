//
//  API+Volumes.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func volumes(page: Page? = nil, completion: @escaping (_ result: Result<[Volume]>) -> Void) -> Handle<[Volume]> {
        let request = self.requestTo(endpoint: .volumes, method: .get, parameters: page)
        return self.taskWith(request: request, keyPath: "volumes", completion: completion)
    }
    
    public func volumeWith(id: String, completion: @escaping (_ result: Result<Volume>) -> Void) -> Handle<Volume> {
        let request = self.requestTo(endpoint: .volumeWithID(id), method: .get)
        return self.taskWith(request: request, keyPath: "volume", completion: completion)
    }
    
    public func volumeWith(name: Volume.Name, page: Page? = nil, completion: @escaping (_ result: Result<[Volume]>) -> Void) -> Handle<[Volume]> {
        let request = self.requestTo(endpoint: .volumes, method: .get, parameters: name.combineWith(convertible: page))
        return self.taskWith(request: request, keyPath: "volumes", completion: completion)
    }
    
    public func create(volume: Volume.CreateRequest, completion: @escaping (_ result: Result<Volume>) -> Void) -> Handle<Volume> {
        let request = self.requestTo(endpoint: .volumes, method: .post, payload: volume)
        return self.taskWith(request: request, keyPath: "volume", completion: completion)
    }
    
    public func delete(volume id: String, completion: @escaping (_ result: Result<Volume>) -> Void) -> Handle<Volume> {
        let request = self.requestTo(endpoint: .volumeWithID(id), method: .delete)
        return self.taskWith(request: request, completion: completion)
    }
    
    public func delete(volume name: Volume.Name, completion: @escaping (_ result: Result<Volume>) -> Void) -> Handle<Volume> {
        let request = self.requestTo(endpoint: .volumes, method: .delete, parameters: name)
        return self.taskWith(request: request, completion: completion)
    }
}
