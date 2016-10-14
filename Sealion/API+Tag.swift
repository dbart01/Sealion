//
//  API+Tag.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func tags(page: Page? = nil, completion: @escaping (_ result: Result<[Tag]>) -> Void) -> Handle<[Tag]> {
        let request = self.requestTo(endpoint: .tags, method: .get, page: page)
        return self.taskWith(request: request, keyPath: "tags", completion: completion)
    }
    
    public func tagWith(name: String, completion: @escaping (_ result: Result<Tag>) -> Void) -> Handle<Tag> {
        let request = self.requestTo(endpoint: .tagWithName(name), method: .get)
        return self.taskWith(request: request, keyPath: "tag", completion: completion)
    }
    
    public func create(tag request: Tag.CreateRequest, completion: @escaping (_ result: Result<Tag>) -> Void) -> Handle<Tag> {
        let request = self.requestTo(endpoint: .tags, method: .post, payload: request)
        return self.taskWith(request: request, keyPath: "tag", completion: completion)
    }
    
    public func update(tag name: String, request: Tag.CreateRequest, completion: @escaping (_ result: Result<Tag>) -> Void) -> Handle<Tag> {
        let request = self.requestTo(endpoint: .tagWithName(name), method: .put, payload: request)
        return self.taskWith(request: request, keyPath: "tag", completion: completion)
    }
    
    public func delete(tag name: String, completion: @escaping (_ result: Result<Tag>) -> Void) -> Handle<Tag> {
        let request = self.requestTo(endpoint: .tagWithName(name), method: .delete)
        return self.taskWith(request: request, completion: completion)
    }
    
    public func assign(tag name: String, request: Tag.TagRequest, completion: @escaping (_ result: Result<Tag>) -> Void) -> Handle<Tag> {
        let request = self.requestTo(endpoint: .tagWithName(name), method: .post, payload: request)
        return self.taskWith(request: request, completion: completion)
    }
    
    public func unassign(tag name: String, request: Tag.TagRequest, completion: @escaping (_ result: Result<Tag>) -> Void) -> Handle<Tag> {
        let request = self.requestTo(endpoint: .tagWithName(name), method: .delete, payload: request)
        return self.taskWith(request: request, completion: completion)
    }
}
