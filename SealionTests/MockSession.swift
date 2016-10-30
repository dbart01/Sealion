//
//  MockSession.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-03.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import UIKit

class MockSession: URLSession {
    
    let responses: [String: Response]
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(stubsNamed stubsName: String) {
        let stubsURL  = Bundle(for: MockSession.self).url(forResource: stubsName, withExtension: "json")!
        let stubsData = try! Data(contentsOf: stubsURL)
        let stubsDict = try! JSONSerialization.jsonObject(with: stubsData, options: []) as! [String: Any]
        
        var responses = [String: Response]()
        for (url, dictionary) in stubsDict {
            responses[url] = Response(json: dictionary as! [String : Any])
        }
        self.responses = responses
    }

    // ----------------------------------
    //  MARK: - Data Task Overrides -
    //
    override func dataTask(with url: URL) -> URLSessionDataTask {
        return MockDataTask()
    }
    
    override func dataTask(with request: URLRequest) -> URLSessionDataTask {
        return MockDataTask()
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = MockDataTask()
        let mock = self.mockFor(url: url)
        
        completionHandler(mock.data, mock.response, nil)
        
        return task
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = MockDataTask()
        let mock = self.mockFor(url: request.url!)
        
        completionHandler(mock.data, mock.response, nil)
        
        return task
    }
    
    // ----------------------------------
    //  MARK: - Responses -
    //
    private func mockFor(url: URL) -> (response: URLResponse, data: Data?) {
        let response     = self.responses[url.absoluteString]
        let httpResponse = HTTPURLResponse(url: url, statusCode: response?.status ?? 404, httpVersion: "1.1", headerFields: response?.headers)!
        let httpData     = response?.jsonData
        
        return (response: httpResponse, data: httpData)
    }
}
