//
//  IntegrationTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-16.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class IntegrationTests: XCTestCase {
    
    typealias Block = () -> Void
    
    let api = API(version: .v2, token: "a4b2f1b7e1f10dab178375189f2a285a18abee5f4e353dcfedae7087e9e25463")
    
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
