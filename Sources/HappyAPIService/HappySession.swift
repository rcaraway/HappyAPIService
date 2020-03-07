//
//  File.swift
//  
//
//  Created by Rob Caraway on 3/7/20.
//

import Foundation

public extension URLSession {
    static func serialSession(delegate: URLSessionDelegate? = nil) -> URLSession {
        let queue = OperationQueue()
        queue.name = "com.SwiftMVP.highPriority"
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInitiated
        return URLSession(configuration: .default, delegate: delegate, delegateQueue: queue)
    }
    
    static func concurrentSession(delegate: URLSessionDelegate? = nil) -> URLSession {
        let queue = OperationQueue()
        queue.name = "com.SwiftMVP.highConcurrentPriority"
        queue.qualityOfService = .userInitiated
        return URLSession(configuration: .default, delegate: delegate, delegateQueue: queue)
    }
    
    static func backgroundSession(delegate: URLSessionDelegate? = nil) -> URLSession {
        let queue = OperationQueue()
        queue.name = "com.SwiftMVP.lowPriority"
        queue.qualityOfService = .background
        return URLSession(configuration: .default, delegate: delegate, delegateQueue: queue)
    }
}

