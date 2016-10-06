//
//  MockSession.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-03.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import UIKit
import Sealion

class MockSession: URLSession {

    private let stubs: [String: Stub]
    private var activeStub: Stub?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(stubsNamed stubsName: String) {
        self.stubs = MockSession.loadStubsNamed(stubsName: stubsName)
    }
    
    // ----------------------------------
    //  MARK: - Loading Responses -
    //
    private static func loadStubsNamed(stubsName: String) -> [String : Stub] {
        
        let stubsURL  = Bundle(for: MockSession.self).url(forResource: stubsName, withExtension: "json")!
        let stubsData = try! Data(contentsOf: stubsURL)
        let stubsDict = try! JSONSerialization.jsonObject(with: stubsData, options: []) as! JSON
        
        var responses = [String: Stub]()
        for (url, dictionary) in stubsDict {
            responses[url] = Stub(json: dictionary as! JSON)
        }
        return responses
    }
    
    // ----------------------------------
    //  MARK: - Mocking -
    //
    func activateMockNamed(name: String) {
        if let stub = self.stubs[name] {
            self.activeStub = stub
        }
    }
    
    func activateStub(stub: Stub) {
        self.activeStub = stub
    }
    
    func deactiveMock() {
        self.activeStub = nil
    }

    // ----------------------------------
    //  MARK: - Data Task Overrides -
    //
    override func dataTask(with url: URL) -> URLSessionDataTask {
        return MockDataTask(resumeHandler: nil)
    }
    
    override func dataTask(with request: URLRequest) -> URLSessionDataTask {
        return MockDataTask(resumeHandler: nil)
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
        let task = MockDataTask {
            completionHandler(mock.data, mock.response, mock.error)
        }
        return task
    }
    
    private func mockResponseForStub(stub: Stub, url: URL) -> (response: URLResponse, data: Data?, error: Error?) {
        let httpResponse = HTTPURLResponse(url: url, statusCode: stub.status, httpVersion: "1.1", headerFields: stub.headers)!
        let httpData     = stub.jsonData
        
        var error: NSError?
        if let stubError = stub.error{
            error = NSError(domain: "MockDomain", code: 500, userInfo: [
                NSLocalizedDescriptionKey : stubError
            ])
        }
        
        return (response: httpResponse, data: httpData, error: error)
    }
}
