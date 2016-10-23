//
//  Result.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-03.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public enum FailureReason {
    
    case unknown
    case cancelled
    case badURL
    case timedOut
    case unsupportedURL
    case cannotFindHost
    case cannotConnectToHost
    case networkConnectionLost
    case dNSLookupFailed
    case HTTPTooManyRedirects
    case resourceUnavailable
    case notConnectedToInternet
    case redirectToNonExistentLocation
    case badServerResponse
    case userCancelledAuthentication
    case userAuthenticationRequired
    case zeroByteResource
    case cannotDecodeRawData
    case cannotDecodeContentData
    case cannotParseResponse
    case fileDoesNotExist
    case fileIsDirectory
    case noPermissionsToReadFile
    case dataLengthExceedsMaximum
    case requiresSecureConnection
    
    init(code: Int?) {
        guard let code = code else {
            self = .unknown
            return
        }
        
        switch code {
        case NSURLErrorUnknown:                       self = .unknown
        case NSURLErrorCancelled:                     self = .cancelled
        case NSURLErrorBadURL:                        self = .badURL
        case NSURLErrorTimedOut:                      self = .timedOut
        case NSURLErrorUnsupportedURL:                self = .unsupportedURL
        case NSURLErrorCannotFindHost:                self = .cannotFindHost
        case NSURLErrorCannotConnectToHost:           self = .cannotConnectToHost
        case NSURLErrorNetworkConnectionLost:         self = .networkConnectionLost
        case NSURLErrorDNSLookupFailed:               self = .dNSLookupFailed
        case NSURLErrorHTTPTooManyRedirects:          self = .HTTPTooManyRedirects
        case NSURLErrorResourceUnavailable:           self = .resourceUnavailable
        case NSURLErrorNotConnectedToInternet:        self = .notConnectedToInternet
        case NSURLErrorRedirectToNonExistentLocation: self = .redirectToNonExistentLocation
        case NSURLErrorBadServerResponse:             self = .badServerResponse
        case NSURLErrorUserCancelledAuthentication:   self = .userCancelledAuthentication
        case NSURLErrorUserAuthenticationRequired:    self = .userAuthenticationRequired
        case NSURLErrorZeroByteResource:              self = .zeroByteResource
        case NSURLErrorCannotDecodeRawData:           self = .cannotDecodeRawData
        case NSURLErrorCannotDecodeContentData:       self = .cannotDecodeContentData
        case NSURLErrorCannotParseResponse:           self = .cannotParseResponse
        case NSURLErrorFileDoesNotExist:              self = .fileDoesNotExist
        case NSURLErrorFileIsDirectory:               self = .fileIsDirectory
        case NSURLErrorNoPermissionsToReadFile:       self = .noPermissionsToReadFile
        case NSURLErrorDataLengthExceedsMaximum:      self = .dataLengthExceedsMaximum
        case NSURLErrorAppTransportSecurityRequiresSecureConnection: self = .requiresSecureConnection
        default:
            self = .unknown
        }
    }
}

public enum Result<T> {   
    case success(object: T?)
    case failure(error: RequestError?, reason: FailureReason)
}
