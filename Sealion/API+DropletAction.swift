//
//  API+DropletAction.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-10.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func action(create action: DropletAction, for id: Int, completion: @escaping (_ result: Result<Action>) -> Void) -> Handle<Action> {
        let request = self.requestTo(endpoint: .dropletActionWithID(id), method: .post, payload: action)
        return self.taskWith(request: request, keyPath: "action", completion: completion)
    }
}
