//
//  MockDataTask.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-03.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

class MockDataTask: URLSessionDataTask {
    
    typealias ResumeHandler = () -> Void
    
    let stub:          Stub
    let resumeHandler: ResumeHandler?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(stub: Stub, resumeHandler: ResumeHandler? = nil) {
        self.stub          = stub
        self.resumeHandler = resumeHandler
    }
    
    // ----------------------------------
    //  MARK: - Overrides -
    //
    private var customState: URLSessionDataTask.State = .suspended
    
    override func cancel() {
        self.customState = .canceling
    }
    
    override func suspend() {
        self.customState = .suspended
    }
    
    override func resume() {
        self.customState = .running
        
        /* -----------------------------------
         ** Mimic an async request by delaying
         ** the completion by the execution
         ** time provided in the stub.
         */
        DispatchQueue.main.asyncAfter(deadline: .now() + self.stub.executionTime) {
            self.customState = .completed
            self.resumeHandler?()
        }
    }
    
    override var state: URLSessionTask.State {
        return self.customState
    }
}
