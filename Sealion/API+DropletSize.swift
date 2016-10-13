//
//  API+DropletSize.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func sizes(completion: @escaping (_ result: Result<[DropletSize]>) -> Void) -> Handle<[DropletSize]> {
        let request = self.requestTo(endpoint: .sizes, method: .get)
        return self.taskWith(request: request, keyPath: "sizes", completion: completion)
    }
}
