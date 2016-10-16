//
//  API+Backup.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-16.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func backupsFor(droplet: Int, completion: @escaping (_ result: Result<[Snapshot]>) -> Void) -> Handle<[Snapshot]> {
        let request = self.requestTo(endpoint: .snapshotsForDroplet(droplet), method: .get)
        return self.taskWith(request: request, keyPath: "snapshots", completion: completion)
    }
}
