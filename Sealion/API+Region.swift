//
//  API+Region.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func regions(completion: @escaping (_ result: Result<[Region]>) -> Void) -> Handle<[Region]> {
        let request = self.requestTo(endpoint: .regions, method: .get)
        return self.taskWith(request: request, keyPath: "regions", completion: completion)
    }
}
