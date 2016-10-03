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
    override func cancel() {}
    override func suspend() {}
    override func resume() {
        self.resumeHandler?()
    }
}
