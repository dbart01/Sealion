//
//  Result.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-03.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T?)
    case failure(String?)
}

public func ==<T: Equatable>(lhs: Result<T>, rhs: Result<T>) -> Bool {
    switch (lhs, rhs) {
    case (.success(let lValue), .success(let rValue)) where lValue == rValue:
        return true
    case (.failure(let lValue), .failure(let rValue)) where lValue == rValue:
        return true
    default:
        return false
    }
}
