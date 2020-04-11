//
//  File.swift
//  
//
//  Created by Rob Caraway on 3/7/20.
//

import Foundation

public enum PollingFrequency: Int {
    case often = 5
    case normal = 10
    case occasionally = 30
    case rarely = 60
}

public protocol PollingAPIServiceDelegate: class {
    func didPoll<T: Decodable>(result: Result<T>)
}

open class PollingAPIService: BaseAPIService {
    weak var delegate: PollingAPIServiceDelegate?
    private var timer: DispatchSourceTimer?
    
    func pollRequest<T: Decodable>(request: URLRequest,
                                   frequency: PollingFrequency = .normal,
                                   responseType: T.Type) {
        let queue = DispatchQueue.global(qos: .background)
        self.timer?.cancel()
        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.schedule(deadline: .now(), repeating: .seconds(frequency.rawValue), leeway: .seconds(3))
        timer.setEventHandler(handler: { [weak self] in
            self?.loadRequest(request: request,
                              responseType: responseType,
                              threadType: .concurrent) { result in
                self?.delegate?.didPoll(result: result)
            }
        })
        timer.resume()
        self.timer = timer
    }
    
    func cancel() { timer?.cancel() }
    
}
