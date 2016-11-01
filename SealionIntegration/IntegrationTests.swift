//
//  IntegrationTests.swift
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
import Sealion

class IntegrationTests: XCTestCase {
    
    typealias Block = () -> Void
    
    var api: API!
    
    // ----------------------------------
    //  MARK: - Setup -
    //
    override func setUp() {
        super.setUp()
        
        if let token = ProcessInfo.processInfo.environment["AUTH_TOKEN"], !token.isEmpty {
            self.api = API(version: .v2, token: token)
        } else {
            fatalError("Failed run integration tests. Missing `AUTH_TOKEN` in current environment. Provide your Digital Ocean OAuth token to run integration tests.")
        }
    }
    
    // ----------------------------------
    //  MARK: - Everything -
    //
    func testEverything() {
        
        /* ---------------------------------
         ** Create resources that we'll need
         ** to conduct the tests.
         */
        let droplet = self.createDroplet()
        let tags    = self.createTags()
        
        /* ---------------------------------
         ** Wait for all the resources to
         ** finish initializing before
         ** running tests.
         */
        _ = self.pollDropletUntilActive(dropletToPoll: droplet)
        
        /* ---------------------------------
         ** Test fetching resources after they
         ** have been successfully created.
         */
        self.fetchDropletsLookingFor(dropletToFind: droplet)
        self.fetchDroplet(droplet: droplet)
        
        /* ---------------------------------
         ** Clean up all the resources that
         ** were used in the tests.
         */
        self.deleteDroplet(droplet: droplet)
    }
    
    // ----------------------------------
    //  MARK: - Creating Resources -
    //
    private func createDroplet() -> Droplet {
        let e = self.expectation(description: "Create droplet")
        
        var droplet: Droplet?
        
        let request = Droplet.CreateRequest(name: "test-droplet", region: "nyc3", size: "512mb", image: "ubuntu-14-04-x64")
        let handle  = self.api.create(droplet: request) { result in
            switch result {
            case .success(let d):
                droplet = d!
            case .failure(let error, _):
                XCTFail(error?.description ?? "Failed to create droplet")
            }
            e.fulfill()
        }
        handle.resume()
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        return droplet!
    }
    
    private func createTags() -> [Tag] {
        let e = self.expectation(description: "Create tags")
        
        let count = 2
        var tags  = [Tag]()
        let group = DispatchGroup()
        
        for i in 0..<count {
            
            group.enter()
            let request = Tag.CreateRequest(name: "test-tag-\(i)")
            let handle  = self.api.create(tag: request) { result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let tag):
                        
                        XCTAssertNotNil(tag)
                        tags.append(tag!)
                        
                    case .failure(let error, _):
                        XCTFail(error?.description ?? "Failed to create tag: \(request.name)")
                    }
                    group.leave()
                }
            }
            handle.resume()
        }
        
        group.notify(queue: DispatchQueue.main) {
            e.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        return tags
    }
    
    // ----------------------------------
    //  MARK: - Polling Resources -
    //
    private func pollDropletUntilActive(dropletToPoll: Droplet) -> Droplet {
        let e = self.expectation(description: "Poll droplet")
        
        var droplet: Droplet?
        
        let handle  = self.api.poll(droplet: dropletToPoll.id, status: .active) { result in
            switch result {
            case .success(let d):
                droplet = d!
            case .failure(let error, _):
                XCTFail(error?.description ?? "Failed to poll droplet")
            }
            e.fulfill()
        }
        handle.resume()
        
        self.waitForExpectations(timeout: 300.0, handler: nil)
        return droplet!
    }
    
    // ----------------------------------
    //  MARK: - Fetching Resources -
    //
//    private func fetchImages() {
//        let e = self.expectation(description: "Fetch Images")
//        
//        let handle = self.api.images(type: .distribution, page: Page(index: 0, count: 200)) { result in
//            e.fulfill()
//        }
//        handle.resume()
//        
//        self.waitForExpectations(timeout: 10.0, handler: nil)
//    }
    
    
    private func fetchDropletsLookingFor(dropletToFind: Droplet) {
        let e = self.expectation(description: "Fetch droplets")
        
        let handle  = self.api.droplets { result in
        switch result {
        case .success(let droplets):
            
            XCTAssertNotNil(droplets)
            let foundDroplet = droplets!.filter { $0.id == dropletToFind.id }.first
            
            XCTAssertNotNil(foundDroplet)
            
        case .failure(let error, _):
            XCTFail(error?.description ?? "Failed to fetch droplets")
        }
            e.fulfill()
        }
        handle.resume()
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    private func fetchDroplet(droplet: Droplet) {
        let e = self.expectation(description: "Fetch droplet")
        
        let handle  = self.api.dropletWith(id: droplet.id) { result in
            switch result {
            case .success(let fetchedDroplet):
                
                XCTAssertNotNil(fetchedDroplet)
                XCTAssertEqual(fetchedDroplet!.id, droplet.id)
                
            case .failure(let error, _):
                XCTFail(error?.description ?? "Failed to fetch droplet")
            }
            e.fulfill()
        }
        handle.resume()
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

    // ----------------------------------
    //  MARK: - Cleaning Up Resources -
    //
    private func deleteDroplet(droplet: Droplet) {
        let e = self.expectation(description: "Delete droplet")
        
        let handle  = self.api.delete(droplet: droplet.id) { result in
            switch result {
            case .success:
                break
            case .failure(let error, _):
                XCTFail(error?.description ?? "Failed to delete droplet")
            }
            e.fulfill()
        }
        handle.resume()
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
}
