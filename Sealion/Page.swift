//
//  Page.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-10.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct Page: ParameterConvertible {
    
    public var index: Int
    public var count: Int
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public init() {
        self.init(index: 0, count: 200)
    }
    
    public init(index: Int, count: Int) {
        self.index = index
        self.count = count
    }
    
    // ----------------------------------
    //  MARK: - ParameterConvertible -
    //
    public var parameters: Parameters {
        
        /* ----------------------------------
         ** Upong conversion to parameters we
         ** have to convert the page 0-based
         ** index to a 1-based ordinality value.
         */
        return [
            "page"     : String(self.index + 1),
            "per_page" : String(self.count),
        ]
    }
}
