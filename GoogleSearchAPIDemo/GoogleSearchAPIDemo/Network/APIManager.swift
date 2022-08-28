//
//  APIManager.swift
//  GoogleSearchAPIDemo
//
//  Created by Harsha on 28/08/2022.
//  Copyright © 2022 Harsha. All rights reserved.
//

import Foundation
import Alamofire

class APIManager: NSObject {
    static let sharedInstance = APIManager()
    
    func addOperationToQueue(operation: APIOperation, completion: @escaping (Bool,Data?) ->Void ) {
        let alamofireSession = Alamofire.Session.default
        guard let url : Alamofire.URLConvertible = operation.url else {
            completion(false,nil)
            return
        }
        let request = alamofireSession.request(url, method: operation.method , parameters: operation.param, headers: operation.header)
        request.responseJSON { response in
            if response.error != nil {
                completion(true,nil)
            }
            completion(true,response.data)
        }
    }
}

class APIOperation: BlockOperation {
    var method: HTTPMethod = .get
    var url : String?
    var header: HTTPHeaders?
    var body: [String: Any]?
    var param: [String: Any] = [:]
    var encoding = URLEncoding.default
    init(header: HTTPHeaders?, method: HTTPMethod?, url: String?, body: [String:Any]?, param: [String: Any]) {
        self.header = header
        self.url = url
        self.body = body
        self.param = param
    }
}

