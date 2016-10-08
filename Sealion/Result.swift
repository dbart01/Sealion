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
    case failure(RequestError?)
}
