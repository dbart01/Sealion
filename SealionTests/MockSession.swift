//
//  MockSession.swift
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

import UIKit
import Sealion

class MockSession: URLSession {

    private let stubs: [String : Stub]
    private var activeStub: Stub?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    override init() {
        self.stubs = [:]
    }
    
    // ----------------------------------
    //  MARK: - Mocking -
    //
    func activateStubkNamed(name: String) {
        if let stub = self.stubs[name] {
            self.activeStub = stub
        }
    }
    
    func activateStub(stub: Stub) {
        self.activeStub = stub
    }
    
    func deactiveStub() {
        self.activeStub = nil
    }

    // ----------------------------------
    //  MARK: - Data Task Overrides -
    //
    override func dataTask(with url: URL) -> URLSessionDataTask {
        fatalError("Unimplemented")
    }
    
    override func dataTask(with request: URLRequest) -> URLSessionDataTask {
        fatalError("Unimplemented")
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        if let activeStub = self.activeStub {
            return self.mockDataTaskWith(stub: activeStub, url: url, completionHandler: completionHandler)
        } else {
            fatalError("Failed to stub request. No active stub provided.")
        }
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        if let activeStub = self.activeStub {
            return self.mockDataTaskWith(stub: activeStub, url: request.url!, completionHandler: completionHandler)
        } else {
            fatalError("Failed to stub request. No active stub provided.")
        }
    }
    
    // ----------------------------------
    //  MARK: - Mock Generation -
    //
    private func mockDataTaskWith(stub: Stub, url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> MockDataTask {
        let mock = self.mockResponseForStub(stub: stub, url: url)
        let task = MockDataTask(stub: stub) {
            completionHandler(mock.data, mock.response, mock.error)
        }
        return task
    }
    
    private func mockResponseForStub(stub: Stub, url: URL) -> (response: URLResponse?, data: Data?, error: Error?) {
        
        var httpResponse: HTTPURLResponse?
        if let status = stub.status {
            httpResponse = HTTPURLResponse(url: url, statusCode: status, httpVersion: "1.1", headerFields: stub.headers)!
        }
        
        let httpData = stub.jsonData
        
        return (response: httpResponse, data: httpData, error: stub.error?.cocoaError())
    }
}
