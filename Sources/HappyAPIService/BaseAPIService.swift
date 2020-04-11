import Foundation

open class BaseAPIService: APIService {
    public private(set) var loadingMap = [String: Bool]()
    public init() {}

    public func loadRequest<T: Decodable>(request: URLRequest,
                                          responseType: T.Type,
                                          threadType: APIServiceType = .serial,
                                          _ completion: @escaping (Result<T>) -> Void) {
        guard !isLoading(request: request) else { return }
        loadingMap[mapString(from: request)] = true
        let task = session(from: threadType).dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data,
                let objectResponse = try? JSONDecoder().decode(responseType, from: data) {
                DispatchQueue.main.async {
                    completion(.success(objectResponse))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.error(error))
                }
            }
            if let strongSelf = self {
                strongSelf.loadingMap[strongSelf.mapString(from: request)] = false
            }
            
        }
        task.resume()
    }
        
}
