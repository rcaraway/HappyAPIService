//
//  File.swift
//  
//
//  Created by Rob Caraway on 3/7/20.
//

import Foundation

public class FakeAPIService: APIService {
    
    public private(set) var loadingMap = [String : Bool]()
    var timer: Timer?
    
    public func loadRequest<T>(request: URLRequest, responseType: T.Type, threadType: APIServiceType, _ completion: @escaping (Result<T>) -> Void) where T : Decodable {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            print("Timer fired!")
            completion(Result.success(nil))
        }
    }
}
