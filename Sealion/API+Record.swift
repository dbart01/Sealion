//
//  API+Record.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-14.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func recordsFor(domain: String, completion: @escaping (_ result: Result<[Record]>) -> Void) -> Handle<[Record]> {
        let request = self.requestTo(endpoint: .recordsForDomain(domain), method: .get)
        return self.taskWith(request: request, keyPath: "domain_records", completion: completion)
    }
    
    public func recordFor(domain: String, id: Int, completion: @escaping (_ result: Result<Record>) -> Void) -> Handle<Record> {
        let request = self.requestTo(endpoint: .recordForDomain(domain, id), method: .get)
        return self.taskWith(request: request, keyPath: "domain_record", completion: completion)
    }
    
    public func create(record request: Record.CreateRequest, domain: String, completion: @escaping (_ result: Result<Record>) -> Void) -> Handle<Record> {
        let request = self.requestTo(endpoint: .recordsForDomain(domain), method: .post, payload: request)
        return self.taskWith(request: request, keyPath: "domain_record", completion: completion)
    }
    
    public func update(record id: Int, request: Record.UpdateRequest, domain: String, completion: @escaping (_ result: Result<Record>) -> Void) -> Handle<Record> {
        let request = self.requestTo(endpoint: .recordForDomain(domain, id), method: .put, payload: request)
        return self.taskWith(request: request, keyPath: "domain_record", completion: completion)
    }
    
    public func delete(record id: Int, domain: String, completion: @escaping (_ result: Result<Record>) -> Void) -> Handle<Record> {
        let request = self.requestTo(endpoint: .recordForDomain(domain, id), method: .delete)
        return self.taskWith(request: request, completion: completion)
    }
}
