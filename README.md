# HappyAPIService

A lightweight, stable APIService for quickly handling requests in Swift. 


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

Use `FakeAPIService` with the same `loadRequest` call to fake a call. 
