//
//  API+Droplet.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-05.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func droplets(tag: String? = nil, completion: @escaping (_ result: Result<[Droplet]>) -> Void) -> Handle<[Droplet]> {
        let parameters: Parameters? = (tag == nil) ? nil : ["tag_name" : tag!]
        let request = self.requestTo(endpoint: .droplets, method: .get, parameters: parameters)
        return self.taskWith(request: request, keyPath: "droplets", completion: completion)
    }
    
    public func dropletWith(id: Int, completion: @escaping (_ result: Result<Droplet>) -> Void) -> Handle<Droplet> {
        let request = self.requestTo(endpoint: .dropletWithID(id), method: .get)
        return self.taskWith(request: request, keyPath: "droplet", completion: completion)
    }
    
    public func create(droplet: Droplet.CreateRequest, completion: @escaping (_ result: Result<Droplet>) -> Void) -> Handle<Droplet> {
        let request = self.requestTo(endpoint: .droplets, method: .post, payload: droplet)
        return self.taskWith(request: request, keyPath: "droplet", completion: completion)
    }
    
    public func create(droplets: Droplet.CreateRequest, completion: @escaping (_ result: Result<[Droplet]>) -> Void) -> Handle<[Droplet]> {
        let request = self.requestTo(endpoint: .droplets, method: .post, payload: droplets)
        return self.taskWith(request: request, keyPath: "droplets", completion: completion)
    }
    
    public func delete(droplet id: Int, completion: @escaping (_ result: Result<Droplet>) -> Void) -> Handle<Droplet> {
        let request = self.requestTo(endpoint: .dropletWithID(id), method: .delete)
        return self.taskWith(request: request, completion: completion)
    }
    
    public func delete(droplets tag: String, completion: @escaping (_ result: Result<Droplet>) -> Void) -> Handle<Droplet> {
        let request = self.requestTo(endpoint: .droplets, method: .delete, parameters: ["tag_name" : tag])
        return self.taskWith(request: request, completion: completion)
    }
}
