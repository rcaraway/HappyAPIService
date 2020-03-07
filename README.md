# HappyAPIService

A lightweight, stable APIService for quickly handling requests in Swift. 

Part of **SwiftMVP**: opinionated components for building apps really fast.

# HappyPath key tenants:
1. Prioritize Speed of development & stability
2. Are not flexible by design.  Get it up and running fast. Fork or PR to customize. 
3. Opinionated to get the job done in its most common use case.  
4. Work in as little lines as needed and are easy to read.

# How to use

Setup including your response:
``` 
    let service = BaseAPIService()
    ...
    struct YourResponse: Decodable { //a response object that mirrors the expected JSON response
        let responseString: String
        let responseDate: Date
        let responseNum: Int
    }
    
    
    let yourRequest = URLRequest(url: yourUrl) //a network URL
```

Normal Use:
```
    service.loadRequest(request: yourRequest,
                        responseType: YourResponse.self) { result in
        // switch result { case let .success(response) case let .error(error) }
    }
```

Low Priority calls:
```
    service.loadRequest(request: yourRequest,
                        responseType: YourResponse.self,
                        threadType: .background) { result in
    }
```

Long Polling:
``` 
    let longPoll = PollingAPIService() 
    longPoll.delegate = self 
    longPoll.pollRequest(request: yourRequest,
                         frequency: .often, 
                         responseType: YourResponse.self)
    
    ...
    
    func didPoll(result: Result<YourResponse>) {
        ...
    }
```
