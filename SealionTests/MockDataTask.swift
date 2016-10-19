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
    
    let resumeHandler: ResumeHandler?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(resumeHandler: ResumeHandler? = nil) {
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
        self.customState = .completed
        self.resumeHandler?()
    }
    
    override var state: URLSessionTask.State {
        return self.customState
    }
}
