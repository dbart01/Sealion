//
//  API+Account.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-02.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func account(completion: @escaping (_ result: Result<Account>) -> Void) -> Handle {
        let request = self.requestTo(endpoint: .account, method: .get)
        return self.taskWith(request: request, keyPath: "account", completion: completion)
    }
}
