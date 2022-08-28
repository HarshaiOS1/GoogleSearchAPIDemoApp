//
//  SearchViewModel.swift
//  GoogleSearchAPIDemo
//
//  Created by wfh on 07/03/20.
//  Copyright © 2020 Harsha. All rights reserved.
//

import Foundation
import Alamofire

class SearchViewModel: NSObject {
    var operationQueue = OperationQueue()
    var searchResult: SearchModel?
    
    //MARK: search using session
    func searchForText(searchText: String, completion: @escaping (Bool, String?) -> Void) {
        let cleanStr = (searchText as NSString).replacingOccurrences(of: " ", with: "")
        let url = Constants.baseurl + "?q=\(cleanStr)&cx=\(Constants.googleCxKey)&key=\(Constants.googleAPIKey)"
        if let googleSearchURl = URL(string: url) {
            var request = URLRequest.init(url: googleSearchURl, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 120)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) {(data, response, error) in
                if error == nil {
                    if Constants.positiveStatusCodes.contains((response as? HTTPURLResponse)?.statusCode ?? 404) {
                        guard let _data = data else {
                            completion(false, "No Search Result")
                            return
                        }
                        do {
                            let string1 = String(data: _data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                            print(string1)
                            let activityLog = try JSONDecoder().decode(SearchModel.self, from: _data)
                            self.searchResult = activityLog
                            completion(true, "Search Result Available")
                        } catch {
                            print(error.localizedDescription)
                            completion(false, error.localizedDescription)
                        }
                    } else {
                        completion(false,"")
                    }
                } else {
                    print(error?.localizedDescription ?? "error")
                    completion(false,"")
                }
            }.resume()
            
        } else {
            print("No url")
        }
    }
    
    //MARK: search using operation
    func getGoogleResult(searchString: String, completion: @escaping (Bool, String?)-> Void ) {
        
        let parameters = ["q" : searchString, "cx": Constants.googleCxKey, "key":Constants.googleAPIKey]
        let apiOperation = APIOperation(header: nil, method: .get, url: Constants.baseurl, body: nil, param: parameters)
        
        apiOperation.addExecutionBlock {[weak self] in
            APIManager.sharedInstance.addOperationToQueue(operation: apiOperation) { success, data in
                if success {
                    do {
                        if let data = data {
                            let string1 = String(data: data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                            print(string1)
                            let activityLog = try JSONDecoder().decode(SearchModel.self, from: data)
                            self?.searchResult = activityLog
                            completion(success, "Search Result Available")
                        } else {
                            completion(success,"error")
                        }
                    } catch {
                        completion(success,"error")
                    }
                }else {
                    completion(success,"error")
                }
            }
        }
        self.operationQueue.addOperation(apiOperation)
    }
}
