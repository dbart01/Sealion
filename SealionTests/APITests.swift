//
//  APITests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-05.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class APITests: XCTestCase {
    
    let token   = "ab837378789f2a87"
    let session = MockSession(stubsNamed: "mocks")
    
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
        let api = self.createAPI()
        
        let expected = URL(string: "\(API.Version.v2.rawValue)account")!
        let url      = api.urlTo(endpoint: .account)
        
        XCTAssertEqual(expected, url)
    }
    
    func testURLGenerationWithParameters() {
        let api = self.createAPI()
        
        let parameters = [
            "page"     : "2",
            "per_page" : "200",
        ]
        
        let expected = URL(string: "\(API.Version.v2.rawValue)droplets/123456?per_page=200&page=2")!
        let url      = api.urlTo(endpoint: .dropletWithID(123456), parameters: parameters)
        
        XCTAssertEqual(expected, url)
    }
    
    // ----------------------------------
    //  MARK: - Request Generation -
    //
    func testRequestGenerationWithoutPayload() {
        let api = self.createAPI()
        
        let request = api.requestTo(endpoint: .actionWithID(123), method: .get)
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "Bearer \(self.token)")
    }
    
    func testRequestGenerationWithPayload() {
        let api = self.createAPI()
        
        let payload = [
            "name"        : "volume",
            "description" : "Test volume",
        ]
        
        let request  = api.requestTo(endpoint: .volumeWithID("volume-identifier"), method: .post, payload: payload)
        
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
        
        let payload = [
            "item" : [
                "firstName" : "John",
                "lastName"  : "Smith",
            ]
        ]
        self.session.activateStub(stub: Stub(status: 200, json: payload))
        let handle = self.runTask()
        
        XCTAssertEqual(handle.response.statusCode, 200)
        
        switch handle.result {
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
        
        self.session.deactiveStub()
    }
    
    func testResponseWithKeyPaths() {
        
        let payload = [
            "company" : [
                "department" : [
                    "employee" : [
                        "name" : "John Smith"
                    ]
                ]
            ]
        ]
        self.session.activateStub(stub: Stub(status: 200, json: payload))
        let handle = self.runTask(keyPath: "company.department.employee")
        
        XCTAssertEqual(handle.response.statusCode, 200)
        
        switch handle.result {
        case .success(let object):
            
            XCTAssertNotNil(object)
            XCTAssertNotNil(object as? JSON, "JSON object is not an expected type.")
            
            let json = object as! [String : String]
            
            XCTAssertEqual(json["name"], "John Smith")
            
        case .failure:
            XCTFail("Expecting successful response.")
        }
        
        self.session.deactiveStub()
    }
    
    func testResponseWithoutPayload() {
        self.session.activateStub(stub: Stub(status: 204, json: nil))
        let handle = self.runTask()
        
        XCTAssertEqual(handle.response.statusCode, 204)
        
        switch handle.result {
        case .success(let object):
            XCTAssertNil(object)
        case .failure:
            XCTFail("Expecting successful response.")
        }

        self.session.deactiveStub()
    }
    
    func testErrorResponseWithoutPayload() {
        self.session.activateStub(stub: Stub(status: 404, json: nil))
        let handle = self.runTask()
        
        XCTAssertEqual(handle.response.statusCode, 404)
        
        switch handle.result {
        case .success:
            XCTFail("Expecting an error response.")
        case .failure(let error):
            XCTAssertNil(error)
        }
        
        self.session.deactiveStub()
    }
    
    func testErrorResponseWithPayload() {
        
        let id          = "1234"
        let name        = "auth_error"
        let description = "You're not allowed in here"
        let payload = [
            "request_id" : id,
            "id"         : name,
            "message"    : description
        ]
        
        self.session.activateStub(stub: Stub(status: 403, json: payload, error: "Something wen't wrong."))
        let handle = self.runTask()
        
        XCTAssertEqual(handle.response.statusCode, 403)
        
        switch handle.result {
        case .success:
            XCTFail("Expecting an error response.")
        case .failure(let error):
            XCTAssertNotNil(error)
            XCTAssertEqual(error!.code,        handle.response.statusCode)
            XCTAssertEqual(error!.id,          id)
            XCTAssertEqual(error!.name,        name)
            XCTAssertEqual(error!.description, description)
        }
        
        self.session.deactiveStub()
    }
    
    func testNetworkErrorResponse() {
        
        let errorDescription = "Network failed"
        self.session.activateStub(stub: Stub(status: 500, json: nil, error: errorDescription))
        let handle = self.runTask()
        
        XCTAssertEqual(handle.response.statusCode, 500)
        
        switch handle.result {
        case .success:
            XCTFail("Expecting an error response.")
        case .failure(let error):
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error!.description, errorDescription)
        }
        
        self.session.deactiveStub()
    }
    
    // ----------------------------------
    //  MARK: - Model Serialization -
    //
    func testModelSingleResponse() {
        
        let payload = [
            "firstName" : "John",
            "lastName"  : "Smith",
        ]
        
        self.session.activateStub(stub: Stub(status: 200, json: payload))
        let result: Result<Person> = self.runObjectTask()
        
        switch result {
        case .success(let person):
            XCTAssertNotNil(person)
            XCTAssertEqual(person!.firstName, "John")
            XCTAssertEqual(person!.lastName,  "Smith")
            
        case .failure:
            XCTFail("Expecting a success response.")
        }
        
        self.session.deactiveStub()
    }
    
    func testModelSingleError() {
        
        self.session.activateStub(stub: Stub(status: 404, json: nil))
        let result: Result<Person> = self.runObjectTask()
        
        switch result {
        case .success:
            XCTFail("Expecting an error response.")
        case .failure(let error):
            XCTAssertNil(error)
        }
        
        self.session.deactiveStub()
    }
    
    func testModelArrayResponse() {
        
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
        
        self.session.activateStub(stub: Stub(status: 200, json: payload))
        let result: Result<[Person]> = self.runObjectTask(keyPath: "people")
        
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
        
        self.session.deactiveStub()
    }
    
    func testModelArrayError() {
        
        self.session.activateStub(stub: Stub(status: 404, json: nil))
        let result: Result<[Person]> = self.runObjectTask()
        
        switch result {
        case .success:
            XCTFail("Expecting an error response.")
        case .failure(let error):
            XCTAssertNil(error)
        }
        
        self.session.deactiveStub()
    }
    
    // ----------------------------------
    //  MARK: - Conveniences -
    //
    private func runObjectTask(keyPath: String? = nil) -> Result<Person> {
        let api = self.createAPI()
        
        var resultOut: Result<Person>!
        
        let e       = self.expectation(description: "")
        let request = api.requestTo(endpoint: .account, method: .get) // overriden by mock
        let task    = api.taskWith(request: request, keyPath: keyPath) { (result: Result<Person>) in
            
            resultOut = result
            e.fulfill()
        }
        task.resume()
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        return resultOut
    }
    
    private func runObjectTask(keyPath: String? = nil) -> Result<[Person]> {
        let api = self.createAPI()
        
        var resultOut: Result<[Person]>!
        
        let e       = self.expectation(description: "")
        let request = api.requestTo(endpoint: .account, method: .get) // overriden by mock
        let task    = api.taskWith(request: request, keyPath: keyPath) { (result: Result<[Person]>) in
            
            resultOut = result
            e.fulfill()
        }
        task.resume()
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        return resultOut
    }
    
    private func runTask(keyPath: String? = nil) -> (result: Result<Any>, response: HTTPURLResponse) {
        let api = self.createAPI()
        
        var resultOut:   Result<Any>!
        var responseOut: HTTPURLResponse!
        
        let e                 = self.expectation(description: "")
        let request           = api.requestTo(endpoint: .account, method: .get) // overriden by mock
        let task: Handle<Any> = api.taskWith(request: request, keyPath: keyPath) { result, response in
            
            resultOut   = result
            responseOut = response
            e.fulfill()
        }
        task.resume()
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        return (resultOut, responseOut)
    }
    
    // ----------------------------------
    //  MARK: - Creating API -
    //
    private func createAPI() -> API {
        return API(version: .v2, token: self.token, session: self.session)
    }
}
