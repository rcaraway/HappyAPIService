//
//  File.swift
//  
//
//  Created by Rob Caraway on 3/7/20.
//

import Foundation

public enum APIServiceType {
    case serial
    case concurrent
    case background
}

public enum Result<T> {
    case error(Error?)
    case success(T?)
}

public protocol APIService {
    var loadingMap: [String: Bool] { get }
    func isLoading(request: URLRequest) -> Bool
    func loadRequest<T: Decodable>(request: URLRequest,
                                   responseType: T.Type,
                                   threadType: APIServiceType,
                                   _ completion: @escaping (Result<T>) -> Void)
    func mapString(from request: URLRequest) -> String
}

extension APIService {
    func session(from type: APIServiceType) -> URLSession {
        switch type {
        case .serial:
            return URLSession.serialSession()
        case .concurrent:
            return URLSession.concurrentSession()
        case .background:
            return URLSession.backgroundSession()
        }
    }
    
    public func isLoading(request: URLRequest) -> Bool {
        let isLoading = loadingMap[mapString(from: request)]
        return (isLoading != nil && isLoading == false)
    }
    public   
    func mapString(from request: URLRequest) -> String {
        var body: String = ""
        if let httpBody = request.httpBody {
            body = String(data: httpBody, encoding: .utf8) ?? ""
        }
        let headers = request.allHTTPHeaderFields?.values.reduce("", +) ?? ""
        return "\(request.url?.absoluteString ?? "")\(request.httpMethod ?? "")\(body)\(headers)"
    }

}
