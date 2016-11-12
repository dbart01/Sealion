//
//  Handle.swift
//  Sealion
//
//  Copyright (c) 2016 Dima Bart
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//  either expressed or implied, of the FreeBSD Project.
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
