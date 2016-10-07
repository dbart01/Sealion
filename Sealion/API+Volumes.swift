//
//  API+Volumes.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    typealias VolumeName = (name: String, regionSlug: String)
    
    public func volumes(completion: @escaping (_ result: Result<[Volume]>) -> Void) -> Handle {
        let request = self.requestTo(endpoint: .volumes, method: .get)
        return self.taskWith(request: request, keyPath: "volumes", completion: completion)
    }
    
    public func create(volume: Volume.CreateRequest, completion: @escaping (_ result: Result<[Volume]>) -> Void) -> Handle {
        let request = self.requestTo(endpoint: .volumes, method: .post, payload: volume)
        return self.taskWith(request: request, keyPath: "volumes", completion: completion)
    }
    
    public func volumeWith(id: String, completion: @escaping (_ result: Result<Volume>) -> Void) -> Handle {
        let request = self.requestTo(endpoint: .volumeWith(id), method: .get)
        return self.taskWith(request: request, keyPath: "volume", completion: completion)
    }
    
    public func volumeWith(name: VolumeName, completion: @escaping (_ result: Result<[Volume]>) -> Void) -> Handle {
        let parameters = [
            "name"   : name.name,
            "region" : name.regionSlug,
        ]
        let request = self.requestTo(endpoint: .volumes, method: .get, parameters: parameters)
        return self.taskWith(request: request, keyPath: "volumes", completion: completion)
    }
    
    public func delete(volume id: String, completion: @escaping (_ result: Result<Volume>) -> Void) -> Handle {
        let request = self.requestTo(endpoint: .volumeWith(id), method: .delete)
        return self.taskWith(request: request, completion: completion)
    }
    
    public func delete(volume name: VolumeName, completion: @escaping (_ result: Result<Volume>) -> Void) -> Handle {
        let parameters = [
            "name"   : name.name,
            "region" : name.regionSlug,
        ]
        let request = self.requestTo(endpoint: .volumes, method: .delete, parameters: parameters)
        return self.taskWith(request: request, completion: completion)
    }
}
