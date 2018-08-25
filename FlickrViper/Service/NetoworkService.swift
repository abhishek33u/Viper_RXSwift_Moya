//
//  NetoworkService.swift
//  VIPERFlickar
//
//  Created by Abhishek Tripathi on 04/07/18.
//  Copyright © 2018 Abhishek Tripathi. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import ObjectMapper
import Moya

enum StubbingMode {
    case sample
    case none
}

///
let apiKey = "76ad09c4b"

enum VIPERFlickarTarget: TargetType {
    
    case getlist(searchString: String, pageSize: Int, pageNumber: Int)
    
    var baseURL: URL {
        
        switch self {
        case let .getlist(searchString, pageSize, pageNumber):
            let string = searchString.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
            return URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(string!)&per_page=\(pageSize)&page=\(pageNumber)&format=json&nojsoncallback=1")!
        }
    }
    
    var path: String {
        switch self {
        case .getlist:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    
    // for ut
    var sampleData: Data {
        return Data()
    }
    
   
     // task
    var task: Task {
            return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}


protocol NetoworkService {
        func callRxServicse<T, U>(target: TargetType, objectType: T.Type) -> Observable<U> where T: Mappable
}

class NetoworkServiceImpl: NetoworkService {
    
    private var stubbingMode: StubbingMode = .none
    
    private var sharedProvider: MoyaProvider<VIPERFlickarTarget> {
        return self.provider()
    }
    
    private func provider() -> MoyaProvider<VIPERFlickarTarget> {
        
        let endpointClosure = { (target: VIPERFlickarTarget) -> Endpoint<VIPERFlickarTarget> in
            let url = URL(target: target).absoluteString
            return Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
        }
        
        let stubClosure: MoyaProvider<VIPERFlickarTarget>.StubClosure = { (Target) -> Moya.StubBehavior in
            
            switch self.stubbingMode {
            case .sample:
                return StubBehavior.immediate
            case .none:
                return  StubBehavior.never
            }
        }
        
        return MoyaProvider<VIPERFlickarTarget>(endpointClosure: endpointClosure, stubClosure: stubClosure,plugins: [NetworkLoggerPlugin(verbose: true)], trackInflights: true)
    }
    
    public func callRxServicse<T, U>(target: TargetType, objectType: T.Type) -> Observable<U> where T: Mappable {
        return Observable.create({ (obserabel) -> Disposable in
            let cancelabel =  self.sharedProvider.request(target as! VIPERFlickarTarget, completion: { (result) in
                switch result {
                case .success(let response):
                    if self.validateResponse(response.statusCode) {
                        if U.self is [T].Type  {
                            do {
                                let exp = try response.mapJSON() as! [[String: Any]]
                                let data = Mapper<T>().mapArray(JSONArray: exp) as! U
                                print(exp)
                                obserabel.onNext(data)
                                obserabel.onCompleted()
                            } catch (let error) {
                                obserabel.onError(error)
                            }
                        } else {
                            do {
                                let exp = try response.mapJSON() as! [String: Any]
                                print(exp)
                                let data = Mapper<T>().map(JSON: exp) as! U
                                obserabel.onNext(data)
                                obserabel.onCompleted()
                            } catch (let error) {
                                // send your owen error
                                obserabel.onError(error)
                            }
                        }
                    } else {
                       
                         // send your owen error/observer.onError(self.handleNetworkError(response: response))
                    }
                    break
                case .failure(_):
                    break
                }
            })
            return Disposables.create {
                cancelabel.cancel()
            }
        })
    }
    
    private func validateResponse(_ statusCode: Int) -> Bool {
        if case 200...500 = statusCode {
            return true
        }
        return false
    }
    
    public func setStubingMode(mode: StubbingMode) {
        self.stubbingMode = mode
    }
}
