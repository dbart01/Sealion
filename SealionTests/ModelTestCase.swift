//
//  ModelTestCase.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-05.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class ModelTestCase: APITestCase {
    
    private let jsonManager = JsonManager(jsonNamed: "models")
    
    // ----------------------------------
    //  MARK: - Json Models -
    //
    func modelNamed<T>(name: String) -> T where T: JsonCreatable {
        let json = self.jsonManager.modelJsonFor(key: name)
        return T(json: json)
    }
    
    // ----------------------------------
    //  MARK: - Assertions -
    //
    func assertEqualityForModelNamed<T>(type: T.Type, name: String) where T: JsonCreatable, T: Equatable {
        let model1: T = self.modelNamed(name: name)
        let model2: T = self.modelNamed(name: name)
        
        XCTAssertEqual(model1, model2)
    }
}
