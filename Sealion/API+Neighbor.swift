//
//  API+Neighbor.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-16.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func neighbors(page: Page? = nil, completion: @escaping (_ result: Result<[Droplet]>) -> Void) -> Handle<[Droplet]> {
        let request = self.requestTo(endpoint: .neighbors, method: .get, page: page)
        return self.taskWith(request: request, keyPath: "neighbors", completion: completion)
    }
    
    public func neighborsFor(droplet: Int, completion: @escaping (_ result: Result<[Droplet]>) -> Void) -> Handle<[Droplet]> {
        let request = self.requestTo(endpoint: .neighborsForDroplet(droplet), method: .get)
        return self.taskWith(request: request, keyPath: "neighbors", completion: completion)
    }
}
