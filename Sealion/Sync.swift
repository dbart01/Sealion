//
//  Sync.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-24.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

// ----------------------------------
//  MARK: - Sync -
//
internal func sync(_ object: AnyObject, task: () -> Void) {
    objc_sync_enter(object)
    task()
    objc_sync_exit(object)
}

internal func sync<T>(_ object: AnyObject, task: () -> T) -> T {
    objc_sync_enter(object)
    let value = task()
    objc_sync_exit(object)
    return value
}
