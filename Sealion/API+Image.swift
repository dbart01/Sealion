//
//  API+Image.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-12.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func images(type: Image.ImageType? = nil, page: Page? = nil, completion: @escaping (_ result: Result<[Image]>) -> Void) -> Handle<[Image]> {
        let request = self.requestTo(endpoint: .images, method: .get, parameters: type)
        return self.taskWith(request: request, keyPath: "images", completion: completion)
    }
    
    public func imageWith(id: Int, completion: @escaping (_ result: Result<Image>) -> Void) -> Handle<Image> {
        let request = self.requestTo(endpoint: .imageWithID(id), method: .get)
        return self.taskWith(request: request, keyPath: "image", completion: completion)
    }
    
    public func imageWith(slug: String, completion: @escaping (_ result: Result<Image>) -> Void) -> Handle<Image> {
        let request = self.requestTo(endpoint: .imageWithSlug(slug), method: .get)
        return self.taskWith(request: request, keyPath: "image", completion: completion)
    }
    
    public func update(image id: Int, request: Image.UpdateRequest, completion: @escaping (_ result: Result<Image>) -> Void) -> Handle<Image> {
        let request = self.requestTo(endpoint: .imageWithID(id), method: .put, payload: request)
        return self.taskWith(request: request, keyPath: "image", completion: completion)
    }
    
    public func delete(image id: Int, completion: @escaping (_ result: Result<Image>) -> Void) -> Handle<Image> {
        let request = self.requestTo(endpoint: .imageWithID(id), method: .delete)
        return self.taskWith(request: request, completion: completion)
    }
}
