//
//  Handle.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-06.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public enum RequestState {
    case running
    case suspended
    case cancelling
    case completed
    
    fileprivate init(state: URLSessionTask.State) {
        switch state {
        case .running:   self = .running
        case .suspended: self = .suspended
        case .canceling: self = .cancelling
        case .completed: self = .completed
        }
    }
}

public final class Handle<T> {
        
    public var state: RequestState {
        return RequestState(state: self.task.state)
    }
    
    internal private(set) var task: URLSessionTask
    internal let keyPath: String?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    internal init(task: URLSessionTask, keyPath: String?) {
        self.task    = task
        self.keyPath = keyPath
    }
    
    // ----------------------------------
    //  MARK: - Set Task -
    //
    internal func setTask(task: URLSessionTask) {
        sync(self) {
            self.task = task
        }
    }
    
    // ----------------------------------
    //  MARK: - Type Comparison -
    //
    internal func typeEqualTo<U>(type: U.Type) -> Bool {
        return false
    }
    
    internal func typeEqualTo(type: T.Type) -> Bool {
        return true
    }
    
    // ----------------------------------
    //  MARK: - Requests -
    //
    public var originalRequest: URLRequest? {
        return sync(self) {
            return self.task.originalRequest
        }
    }
    
    public var currentRequest: URLRequest? {
        return sync(self) {
            return self.task.currentRequest
        }
    }
    
    // ----------------------------------
    //  MARK: - Response -
    //
    public var response: URLResponse? {
        return sync(self) {
            return self.task.response
        }
    }
    
    // ----------------------------------
    //  MARK: - Actions -
    //
    public func cancel() {
        sync(self) {
            self.task.cancel()
        }
    }
    
    public func suspend() {
        sync(self) {
            self.task.suspend()
        }
    }
    
    public func resume() {
        sync(self) {
            self.task.resume()
        }
    }
}

private class Sync {
    
    weak var target: AnyObject!
    
    @discardableResult init(target: AnyObject) {
        self.target = target
        objc_sync_enter(target)
    }
    
    deinit {
        objc_sync_exit(self.target)
    }
}

private func sync(_ object: AnyObject, task: () -> Void) {
    objc_sync_enter(object)
    task()
    objc_sync_exit(object)
}

private func sync<T>(_ object: AnyObject, task: () -> T) -> T {
    objc_sync_enter(object)
    let value = task()
    objc_sync_exit(object)
    return value
}
