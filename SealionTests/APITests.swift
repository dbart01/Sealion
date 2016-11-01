//
//  APITests.swift
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

import XCTest
@testable import Sealion

class APITests: XCTestCase {
    
    let token = "ab837378789f2a87"
    
    let nonPollingHandler: (Result<Any>) -> Bool = {
        return { result in
            return false
        }
    }()
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testInit() {
        let token = "a1a2a3a4a5a6"
        let version: API.Version = .v2
        
        let api = API(version: version, token: token)
        
        XCTAssertNotNil(api)
        XCTAssertEqual(api.version, version)
        XCTAssertEqual(api.token,   token)
    }
    
    // ----------------------------------
    //  MARK: - URL Generation -
    //
    func testURLGenerationWithoutParameters() {
        let suite = self.create()
        
        let expected = URL(string: "\(API.Version.v2.rawValue)account")!
        let url      = suite.api.urlTo(endpoint: .account)
        
        XCTAssertEqual(expected, url)
    }
    
    func testURLGenerationWithParameters() {
        let suite = self.create()
        
        let parameters = [
            "id"    : "2",
            "image" : "200",
        ]
        
        let expectedWithoutPage = URL(string: "\(API.Version.v2.rawValue)droplets/123456?id=2&image=200")!
        let urlWithoutPage      = suite.api.urlTo(endpoint: .dropletWithID(123456), parameters: parameters)
        
        XCTAssertEqual(expectedWithoutPage, urlWithoutPage)
        
        let page = Page(index: 0, count: 50)
        
        let expectedWithPage = URL(string: "\(API.Version.v2.rawValue)droplets/123456?page=1&per_page=50&id=2&image=200")!
        let urlWithPage      = suite.api.urlTo(endpoint: .dropletWithID(123456), page: page, parameters: parameters)
        
        XCTAssertEqual(expectedWithPage, urlWithPage)
    }
    
    // ----------------------------------
    //  MARK: - Result Mapping -
    //
    func testMapModelNonNil() {
        let suite = self.create()
        
        let curried: (API) -> (Any?) -> Domain? = API.mapModelFrom
        let method = curried(suite.api)
        
        let model: JSON = [
            "name"      : "example.com",
            "zone_file" : "some zone file",
            "ttl"       : 1800,
        ]
        
        let domain = method(model)
        
        XCTAssertNotNil(domain)
        XCTAssertEqual(domain!.name, model["name"]      as! String)
        XCTAssertEqual(domain!.zone, model["zone_file"] as? String)
        XCTAssertEqual(domain!.ttl,  model["ttl"]       as! Int)
    }
    
    func testMapModelNil() {
        let suite = self.create()
        
        let curried: (API) -> (Any?) -> Domain? = API.mapModelFrom
        let method = curried(suite.api)
        let domain = method(nil)
        
        XCTAssertNil(domain)
    }
    
    func testMapCollectionNonNil() {
        let suite = self.create()
        
        let curried: (API) -> (Any?) -> [Domain]? = API.mapModelCollectionFrom
        let method = curried(suite.api)
        
        let models: [JSON] = [
            [
                "name"      : "example.com",
                "zone_file" : "some zone file",
                "ttl"       : 1800,
            ],
            [
                "name"      : "other.com",
                "zone_file" : "some other zone file",
                "ttl"       : 1800,
            ],
        ]
        
        let domains = method(models)
        
        XCTAssertNotNil(domains)
        XCTAssertEqual(domains!.count, 2)
        
        XCTAssertEqual(domains![0].name, models[0]["name"]      as! String)
        XCTAssertEqual(domains![0].zone, models[0]["zone_file"] as? String)
        XCTAssertEqual(domains![0].ttl,  models[0]["ttl"]       as! Int)
        
        XCTAssertEqual(domains![1].name, models[1]["name"]      as! String)
        XCTAssertEqual(domains![1].zone, models[1]["zone_file"] as? String)
        XCTAssertEqual(domains![1].ttl,  models[1]["ttl"]       as! Int)
    }
    
    func testMapCollectionNil() {
        let suite = self.create()
        
        let curried: (API) -> (Any?) -> [Domain]? = API.mapModelCollectionFrom
        let method  = curried(suite.api)
        let domains = method(nil)
        
        XCTAssertNil(domains)
    }
    
    // ----------------------------------
    //  MARK: - Request Generation -
    //
    func testRequestGenerationWithoutPayload() {
        let suite   = self.create()
        let request = suite.api.requestTo(endpoint: .actionWithID(123), method: .get)
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "Bearer \(self.token)")
    }
    
    func testRequestGenerationWithPayload() {
        let suite   = self.create()
        let payload = [
            "name"        : "volume",
            "description" : "Test volume",
        ]
        
        let request  = suite.api.requestTo(endpoint: .volumeWithID("volume-identifier"), method: .post, payload: payload)
        
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "Bearer \(self.token)")
        
        let bodyData     = request.httpBody!
        let expectedData = try! JSONSerialization.data(withJSONObject: payload, options: [])
        
        XCTAssertEqual(bodyData, expectedData)
    }
    
    // ----------------------------------
    //  MARK: - Response Serialization -
    //
    func testResponseWithPayload() {
        
        let suite   = self.create()
        let payload = [
            "item" : [
                "firstName" : "John",
                "lastName"  : "Smith",
            ]
        ]
        suite.session.activateStub(stub: Stub(status: 200, json: payload))
        let result = self.runTask(api: suite.api, pollHandler: self.nonPollingHandler)
        
        switch result {
        case .success(let object):
            
            XCTAssertNotNil(object)
            XCTAssertNotNil(object as? JSON, "JSON object is not an expected type.")
            
            let json = object as! JSON
            
            XCTAssertNotNil(json["item"])
            
            let dictionary = json["item"] as! [String : String]
            
            XCTAssertEqual(dictionary["firstName"], "John")
            XCTAssertEqual(dictionary["lastName"],  "Smith")
            
        case .failure:
            XCTFail("Expecting successful response.")
        }
        
        suite.session.deactiveStub()
    }
    
    func testResponseWithKeyPaths() {
        
        let suite   = self.create()
        let payload = [
            "company" : [
                "department" : [
                    "employee" : [
                        "name" : "John Smith"
                    ]
                ]
            ]
        ]
        suite.session.activateStub(stub: Stub(status: 200, json: payload))
        let result = self.runTask(api: suite.api, keyPath: "company.department.employee", pollHandler: self.nonPollingHandler)
        
        switch result {
        case .success(let object):
            
            XCTAssertNotNil(object)
            XCTAssertNotNil(object as? JSON, "JSON object is not an expected type.")
            
            let json = object as! [String : String]
            
            XCTAssertEqual(json["name"], "John Smith")
            
        case .failure:
            XCTFail("Expecting successful response.")
        }
        
        suite.session.deactiveStub()
    }
    
    func testResponseWithoutPayload() {
        let suite = self.create()
        
        suite.session.activateStub(stub: Stub(status: 204, json: nil))
        let result = self.runTask(api: suite.api, pollHandler: self.nonPollingHandler)
        
        switch result {
        case .success(let object):
            XCTAssertNil(object)
        case .failure:
            XCTFail("Expecting successful response.")
        }

        suite.session.deactiveStub()
    }
    
    func testErrorResponseWithoutPayload() {
        let suite = self.create()
        
        suite.session.activateStub(stub: Stub(status: 404, json: nil))
        let result = self.runTask(api: suite.api, pollHandler: self.nonPollingHandler)
        
        switch result {
        case .success:
            XCTFail("Expecting an error response.")
        case .failure(let error, let reason):
            XCTAssertEqual(reason, .unknown)
            XCTAssertNil(error)
        }
        
        suite.session.deactiveStub()
    }
    
    func testErrorResponseWithPayload() {
        
        let suite       = self.create()
        let error       = MockError(code: -100, description: "Something went wrong")
        let id          = "1234"
        let name        = "auth_error"
        let description = "You're not allowed in here"
        let payload     = [
            "request_id" : id,
            "id"         : name,
            "message"    : description
        ]
        
        suite.session.activateStub(stub: Stub(status: 403, json: payload, error: error))
        let result = self.runTask(api: suite.api, pollHandler: self.nonPollingHandler)
        
        switch result {
        case .success:
            XCTFail("Expecting an error response.")
        case .failure(let error, let reason):
            
            XCTAssertEqual(reason, .unknown)
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error!.code,        403)
            XCTAssertEqual(error!.id,          id)
            XCTAssertEqual(error!.name,        name)
            XCTAssertEqual(error!.description, description)
        }
        
        suite.session.deactiveStub()
    }
    
    func testNetworkErrorResponse() {
        
        let suite = self.create()
        let error = MockError(code: NSURLErrorNotConnectedToInternet)
        
        suite.session.activateStub(stub: Stub(error: error))
        let result = self.runTask(api: suite.api, pollHandler: self.nonPollingHandler)
        
        switch result {
        case .success:
            XCTFail("Expecting an error response.")
        case .failure(let error, let reason):
            
            XCTAssertNil(error)
            XCTAssertEqual(reason, .notConnectedToInternet)
        }
        
        suite.session.deactiveStub()
    }
    
    func testPolling() {
        let suite = self.create()
        
        let assertResult: (Result<Any>) -> Void = { result in
            
            switch result {
            case .success(let object):
                
                XCTAssertNotNil(object)
                let json = object as! JSON
                XCTAssertEqual(json["message"] as! String, "OK")
                
            case .failure:
                XCTFail("Expecting a success response.")
            }
        }
        
        let payload = ["message" : "OK"]
        var count   = 0
        
        suite.session.activateStub(stub: Stub(status: 204, json: payload))
        let result = self.runTask(api: suite.api, pollHandler: { result in
            
            assertResult(result)
            count += 1
            
            // Poll while count is less than 3
            return count < 3
        })
        
        XCTAssertEqual(count, 3)
        assertResult(result)
        
        suite.session.deactiveStub()
    }
    
    func testCancellationBeforePolling() {
        
        let suite = self.create()
        let error = MockError(domain: NSCocoaErrorDomain, code: NSURLErrorCancelled, description: "Request was cancelled")
        
        suite.session.activateStub(stub: Stub(error: error))
        let e = self.expectation(description: "")
        
        let request           = suite.api.requestTo(endpoint: .account, method: .get) // overriden by mock
        let task: Handle<Any> = suite.api.taskWith(request: request, transformer: APITests.passthroughTransformer(self), pollHandler: { result in
            
            XCTFail("Cancelled request should not execute the polling handler.")
            return true
            
        }, completion: { result in
            
            switch result {
            case .success:
                XCTFail("Expecting a failure response.")
            case .failure(let error, let reason):
                XCTAssertNil(error)
                XCTAssertEqual(reason, .cancelled)
            }
            e.fulfill()
        })
        
        task.resume()
        task.cancel()
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        suite.session.deactiveStub()
    }
    
    func testCancellationDuringPolling() {
        
        let suite  = self.create()
        var polled = 0
        
        suite.session.activateStub(stub: Stub(status: 204))
        
        let request = suite.api.requestTo(endpoint: .account, method: .get) // overriden by mock
        
        var task: Handle<Any>!
        task = suite.api.taskWith(request: request, transformer: APITests.passthroughTransformer(self), pollHandler: { result in
            
            polled += 1
            if polled == 1 {
                
                task.cancel()
                
            } else {
                XCTFail("Cancelled request should not execute the polling handler again.")
            }
            return polled == 1
            
        }, pollInterval: 0.0, completion: { result in
            
            switch result {
            case .success:
                XCTAssertEqual(polled, 1)
            case .failure:
                XCTFail("Expecting a failure response.")
            }
        })
        
        task.resume()
        
        suite.session.deactiveStub()
    }
    
    // ----------------------------------
    //  MARK: - Model Serialization -
    //
    func testModelSingleResponse() {
        
        let suite   = self.create()
        let payload = [
            "firstName" : "John",
            "lastName"  : "Smith",
        ]
        
        suite.session.activateStub(stub: Stub(status: 200, json: payload))
        let result: Result<Person> = self.runObjectTask(api: suite.api)
        
        switch result {
        case .success(let person):
            XCTAssertNotNil(person)
            XCTAssertEqual(person!.firstName, "John")
            XCTAssertEqual(person!.lastName,  "Smith")
            
        case .failure:
            XCTFail("Expecting a success response.")
        }
        
        suite.session.deactiveStub()
    }
    
    func testModelSingleError() {
        let suite = self.create()
        
        suite.session.activateStub(stub: Stub(status: 404, json: nil))
        let result: Result<Person> = self.runObjectTask(api: suite.api)
        
        switch result {
        case .success:
            XCTFail("Expecting an error response.")
        case .failure(let error, let reason):
            XCTAssertEqual(reason, .unknown)
            XCTAssertNil(error)
        }
        
        suite.session.deactiveStub()
    }
    
    func testModelSinglePolling() {
        
        let suite   = self.create()
        let payload = [
            "firstName" : "John",
            "lastName"  : "Smith",
        ]
        
        let assertResult: (Result<Person>) -> Void = { result in
            
            switch result {
            case .success(let person):
                
                XCTAssertNotNil(person)
                XCTAssertEqual(person!.firstName, "John")
                XCTAssertEqual(person!.lastName, "Smith")
                
            case .failure:
                XCTFail("Expecting a success response.")
            }
        }
        
        var count = 0
        
        suite.session.activateStub(stub: Stub(status: 200, json: payload))
        let result: Result<Person> = self.runObjectTask(api: suite.api, pollHandler: { result in
            
            assertResult(result)
            count += 1
            
            // Poll while count is less than 3
            return count < 3
        })
        
        XCTAssertEqual(count, 3)
        assertResult(result)
        
        suite.session.deactiveStub()
    }
    
    func testModelArrayResponse() {
        
        let suite   = self.create()
        let payload = [
            "people": [
                [
                    "firstName" : "John",
                    "lastName"  : "Smith",
                ],
                [
                    "firstName" : "Walter",
                    "lastName"  : "Appleseed",
                ]
            ]
        ]
        
        suite.session.activateStub(stub: Stub(status: 200, json: payload))
        let result: Result<[Person]> = self.runObjectTask(api: suite.api, keyPath: "people")
        
        switch result {
        case .success(let people):
            XCTAssertNotNil(people)
            XCTAssertEqual(people!.count, 2)
            
            guard let people = people else { return }
            
            XCTAssertEqual(people[0].firstName, "John")
            XCTAssertEqual(people[0].lastName,  "Smith")
            XCTAssertEqual(people[1].firstName, "Walter")
            XCTAssertEqual(people[1].lastName,  "Appleseed")
            
        case .failure:
            XCTFail("Expecting a success response.")
        }
        
        suite.session.deactiveStub()
    }
    
    func testModelArrayError() {
        let suite = self.create()
        
        suite.session.activateStub(stub: Stub(status: 404, json: nil))
        let result: Result<[Person]> = self.runObjectTask(api: suite.api)
        
        switch result {
        case .success:
            XCTFail("Expecting an error response.")
        case .failure(let error, let reason):
            XCTAssertEqual(reason, .unknown)
            XCTAssertNil(error)
        }
        
        suite.session.deactiveStub()
    }
    
    func testModelArrayPolling() {
        let suite   = self.create()
        let payload = [
            "people": [
                [
                    "firstName" : "John",
                    "lastName"  : "Smith",
                ],
                [
                    "firstName" : "Walter",
                    "lastName"  : "Appleseed",
                ]
            ]
        ]
        
        let assertResult: (Result<[Person]>) -> Void = { result in
            
            switch result {
            case .success(let people):
                
                XCTAssertNotNil(people)
                
                guard let people = people else { return }
                
                XCTAssertEqual(people.count, 2)
                XCTAssertEqual(people[0].firstName, "John")
                XCTAssertEqual(people[0].lastName,  "Smith")
                XCTAssertEqual(people[1].firstName, "Walter")
                XCTAssertEqual(people[1].lastName,  "Appleseed")
                
            case .failure:
                XCTFail("Expecting a success response.")
            }
        }
        
        var count = 0
        
        suite.session.activateStub(stub: Stub(status: 200, json: payload))
        let result: Result<[Person]> = self.runObjectTask(api: suite.api, keyPath: "people", pollHandler: { result in
            
            assertResult(result)
            count += 1
            
            // Poll while count is less than 3
            return count < 3
        })
        
        XCTAssertEqual(count, 3)
        assertResult(result)
        
        suite.session.deactiveStub()
    }
    
    // ----------------------------------
    //  MARK: - Conveniences -
    //
    private func runObjectTask(api: API, keyPath: String? = nil, pollHandler: ((Result<Person>) -> Bool)? = nil) -> Result<Person> {
        var resultOut: Result<Person>!
        
        let request = api.requestTo(endpoint: .account, method: .get) // overriden by mock
        let task    = api.taskWith(request: request, keyPath: keyPath, pollHandler: pollHandler, pollInterval: 0.0) { (result: Result<Person>) in
            
            resultOut = result
        }
        task.resume()
        
        return resultOut
    }
    
    private func runObjectTask(api: API, keyPath: String? = nil, pollHandler: ((Result<[Person]>) -> Bool)? = nil) -> Result<[Person]> {
        var resultOut: Result<[Person]>!
        
        let request = api.requestTo(endpoint: .account, method: .get) // overriden by mock
        let task    = api.taskWith(request: request, keyPath: keyPath, pollHandler: pollHandler, pollInterval: 0.0) { (result: Result<[Person]>) in
            
            resultOut = result
        }
        task.resume()
        
        return resultOut
    }
    
    private func runTask(api: API, keyPath: String? = nil, pollHandler: @escaping (Result<Any>) -> Bool) -> Result<Any> {
        var resultOut: Result<Any>!
        
        let request           = api.requestTo(endpoint: .account, method: .get) // overriden by mock
        let task: Handle<Any> = api.taskWith(request: request, keyPath: keyPath, transformer: APITests.passthroughTransformer(self), pollHandler: { result in
            
            return pollHandler(result)
            
        }, pollInterval: 0.0, completion: { result in
            resultOut = result
        })
        task.resume()
        
        return resultOut
    }
    
    // ----------------------------------
    //  MARK: - Creating API -
    //
    private func create() -> (api: API, session: MockSession) {
        let session = MockSession()
        let api     = API(version: .v2, token: self.token, session: session)
        
        return (api, session)
    }
    
    // ----------------------------------
    //  MARK: - Transformer -
    //
    private func passthroughTransformer<T>(json: Any?) -> T? {
        return json as? T
    }
}
