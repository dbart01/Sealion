//
//  API+Account.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-02.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func account(completion: @escaping (_ result: Response<Account>) -> Void) {
        let request = self.requestTo(endpoint: .account, method: .get)
        let task    = self.taskWith(request: request, keyPath: "account", completion: completion)
        
        task.resume()
    }
}
