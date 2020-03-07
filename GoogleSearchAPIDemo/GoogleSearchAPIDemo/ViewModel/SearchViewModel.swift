//
//  SearchViewModel.swift
//  GoogleSearchAPIDemo
//
//  Created by wfh on 07/03/20.
//  Copyright © 2020 Harsha. All rights reserved.
//

import Foundation

class SearchViewModel: NSObject {
    var searchResult: GoogleResponse?
    
    let googleAPIKey = "AIzaSyCHFqOHSue7ozspCqmAvbIlTjsflpnBkLg" //Move to constant files
    static let positiveStatusCodes = [200,201,202,203,204]//Move to constant files
    
    func searchForText(searchText: String, completion: @escaping (Bool, String?) -> Void) {
        let cleanStr = (searchText as NSString).replacingOccurrences(of: " ", with: "")
        let url = "https://www.googleapis.com/customsearch/v1?q=%@&cx=011476162607576381860:ra4vmliv9ti&key=%@"
        let urlstring = String(format: url, arguments: [cleanStr, googleAPIKey])
        if let googleSearchURl = URL(string: urlstring) {
            
            var request = URLRequest.init(url: googleSearchURl, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 120)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("no-cache", forHTTPHeaderField: "cache-control")
            
            URLSession.shared.dataTask(with: request) {(data, response, error) in
                if error == nil {
                    if SearchViewModel.positiveStatusCodes.contains((response as? HTTPURLResponse)?.statusCode ?? 404) {
                        guard let _data = data else {
                            completion(false, "No Search Result")
                            return
                        }
                        do {
                            let string1 = String(data: _data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                            print(string1)
                            let activityLog = try JSONDecoder().decode(GoogleResponse.self, from: _data)
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
}

// MARK: - googleResponse
struct GoogleResponse: Codable {
    let kind: String?
//    let url: URLClass?
//    let queries: Queries?
//    let context: Context?
//    let searchInformation: SearchInformation?
//    let spelling: Spelling?
    let items: [Item]?
}

// MARK: - Context
struct Context: Codable {
    let title: String?
}

// MARK: - Item
struct Item: Codable {
    let kind: Kind?
    let title: String?
    let link: String?
//    let displayLink: DisplayLink?
//    let snippet, htmlSnippet, cacheID: String?
//    let formattedURL, htmlFormattedURL: String?
    let pagemap: Pagemap?
    
    enum CodingKeys: String, CodingKey {
        case kind, title, link
//        , htmlTitle, displayLink, snippet, htmlSnippet
//        case cacheID = "cacheId"
//        case formattedURL = "formattedUrl"
//        case htmlFormattedURL = "htmlFormattedUrl"
        case pagemap
    }
}

enum DisplayLink: String, Codable {
    case wwwGoogleCOM = "www.google.com"
}

enum Kind: String, Codable {
    case customsearchResult = "customsearch#result"
}

// MARK: - Pagemap
struct Pagemap: Codable {
    let cseThumbnail: [CSEThumbnail]?
//    let metatags: [Metatag]?
//    let cseImage: [CSEImage]?
//    let website: [Website]?
//    let product: [Product]?
//    let hproduct: [Hproduct]?
    
    enum CodingKeys: String, CodingKey {
        case cseThumbnail = "cse_thumbnail"
//        case metatags
//        case cseImage = "cse_image"
//        case website, product, hproduct
    }
}

// MARK: - CSEImage
struct CSEImage: Codable {
    let src: String?
}

// MARK: - CSEThumbnail
struct CSEThumbnail: Codable {
    let width, height: String?
    let src: String?
}

// MARK: - Hproduct
struct Hproduct: Codable {
    let fn: String?
}

// MARK: - Metatag
struct Metatag: Codable {
    let viewport, appleItunesApp, fbAppID, ogSiteName: String?
    let twitterSite, author, ogTitle: String?
    let ogImage: String?
    let ogUpdatedTime: Date?
    let ogURL: String?
    let ogDescription, ogType, twitterCard, twitterTitle: String?
    let twitterDescription: String?
    let twitterImage: String?
    let twitterCreator: String?
    let articlePublisher: String?
    let articleAuthor, articleSection: String?
    let articleSectionURL: String?
    let articleID, articlePublished, articleModified, referrer: String?
    let google, themeColor, ogImageWidth, ogImageHeight: String?
    let twitterImageSrc: String?
    let formatDetection: String?
    
    enum CodingKeys: String, CodingKey {
        case viewport
        case appleItunesApp = "apple-itunes-app"
        case fbAppID = "fb:app_id"
        case ogSiteName = "og:site_name"
        case twitterSite = "twitter:site"
        case author
        case ogTitle = "og:title"
        case ogImage = "og:image"
        case ogUpdatedTime = "og:updated_time"
        case ogURL = "og:url"
        case ogDescription = "og:description"
        case ogType = "og:type"
        case twitterCard = "twitter:card"
        case twitterTitle = "twitter:title"
        case twitterDescription = "twitter:description"
        case twitterImage = "twitter:image"
        case twitterCreator = "twitter:creator"
        case articlePublisher = "article:publisher"
        case articleAuthor = "article:author"
        case articleSection = "article:section"
        case articleSectionURL = "article:section_url"
        case articleID = "article:id"
        case articlePublished = "article:published"
        case articleModified = "article:modified"
        case referrer, google
        case themeColor = "theme-color"
        case ogImageWidth = "og:image:width"
        case ogImageHeight = "og:image:height"
        case twitterImageSrc = "twitter:image:src"
        case formatDetection = "format-detection"
    }
}

// MARK: - Product
struct Product: Codable {
    let name, reviewcount: String?
}

// MARK: - Website
struct Website: Codable {
    let name, websiteDescription: String?
    let url, image: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case websiteDescription = "description"
        case url, image
    }
}

// MARK: - Queries
struct Queries: Codable {
    let request, nextPage: [NextPage]?
}

// MARK: - NextPage
struct NextPage: Codable {
    let title, totalResults, searchTerms: String?
    let count, startIndex: Int?
    let inputEncoding, outputEncoding, safe, cx: String?
}

// MARK: - SearchInformation
struct SearchInformation: Codable {
    let searchTime: Double?
    let formattedSearchTime, totalResults, formattedTotalResults: String?
}

// MARK: - Spelling
struct Spelling: Codable {
    let correctedQuery, htmlCorrectedQuery: String?
}

// MARK: - URLClass
struct URLClass: Codable {
    let type, template: String?
}
