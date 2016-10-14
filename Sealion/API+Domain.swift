//
//  API+Domain.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-14.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func domains(page: Page? = nil, completion: @escaping (_ result: Result<[Domain]>) -> Void) -> Handle<[Domain]> {
        let request = self.requestTo(endpoint: .domains, method: .get, page: page)
        return self.taskWith(request: request, keyPath: "domains", completion: completion)
    }
    
    public func domainWith(name: String, completion: @escaping (_ result: Result<Domain>) -> Void) -> Handle<Domain> {
        let request = self.requestTo(endpoint: .domainWithName(name), method: .get)
        return self.taskWith(request: request, keyPath: "domain", completion: completion)
    }
    
    public func create(domain request: Domain.CreateRequest, completion: @escaping (_ result: Result<Domain>) -> Void) -> Handle<Domain> {
        let request = self.requestTo(endpoint: .domains, method: .post, payload: request)
        return self.taskWith(request: request, keyPath: "domain", completion: completion)
    }
    
    public func delete(domain name: String, completion: @escaping (_ result: Result<Domain>) -> Void) -> Handle<Domain> {
        let request = self.requestTo(endpoint: .domainWithName(name), method: .delete)
        return self.taskWith(request: request, completion: completion)
    }
}
