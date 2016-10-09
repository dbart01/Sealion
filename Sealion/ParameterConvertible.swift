//
//  ParameterConvertible.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-09.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public typealias Parameters = [String : String]

public protocol ParameterConvertible {
    var parameters: Parameters { get }
}

extension Dictionary: ParameterConvertible {
    
    public var parameters: Parameters {
        return self as Any as! Parameters
    }
}
