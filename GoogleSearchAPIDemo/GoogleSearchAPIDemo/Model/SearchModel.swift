//
//  SearchModel.swift
//  GoogleSearchAPIDemo
//
//  Created by Harsha on 24/08/2022.
//  Copyright © 2022 Harsha. All rights reserved.
//

import Foundation

// MARK: - SearchModel
struct SearchModel: Codable {
    let kind: String
    let items: [Item]
}

// MARK: - Context
struct Context: Codable {
    let title: String
}

// MARK: - Item
struct Item: Codable {
    let kind: Kind?
    let title: String?
    let link: String?
    let pagemap: Pagemap?
    
    enum CodingKeys: String, CodingKey {
        case kind, title, link
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
    enum CodingKeys: String, CodingKey {
        case cseThumbnail = "cse_thumbnail"
    }
}

// MARK: - CSEImage
struct CSEImage: Codable {
    let src: String?
}

// MARK: - CSEThumbnail
struct CSEThumbnail: Codable {
    let src: String
    let width, height: String
}

// MARK: - Metatag
struct Metatag: Codable {
    let referrer: String?
    let viewport: String
    let google, formatDetection: String?
    let ogImage: String?
    let twitterCard, twitterTitle, ogImageWidth, ogType: String?
    let twitterSite, twitterDescription, ogTitle, ogImageHeight: String?
    let ogDescription: String?
    let twitterImage: String?
    let ogURL: String?
    let ogSiteName, applicationName, appleMobileWebAppTitle, appleMobileWebAppStatusBarStyle: String?
    let msapplicationTapHighlight: String?
    
    enum CodingKeys: String, CodingKey {
        case referrer, viewport, google
        case formatDetection = "format-detection"
        case ogImage = "og:image"
        case twitterCard = "twitter:card"
        case twitterTitle = "twitter:title"
        case ogImageWidth = "og:image:width"
        case ogType = "og:type"
        case twitterSite = "twitter:site"
        case twitterDescription = "twitter:description"
        case ogTitle = "og:title"
        case ogImageHeight = "og:image:height"
        case ogDescription = "og:description"
        case twitterImage = "twitter:image"
        case ogURL = "og:url"
        case ogSiteName = "og:site_name"
        case applicationName = "application-name"
        case appleMobileWebAppTitle = "apple-mobile-web-app-title"
        case appleMobileWebAppStatusBarStyle = "apple-mobile-web-app-status-bar-style"
        case msapplicationTapHighlight = "msapplication-tap-highlight"
    }
}

// MARK: - Place
struct Place: Codable {
    let image: String
    let name, placeDescription: String
    
    enum CodingKeys: String, CodingKey {
        case image, name
        case placeDescription = "description"
    }
}

// MARK: - Queries
struct Queries: Codable {
    let request, nextPage: [NextPage]
}

// MARK: - NextPage
struct NextPage: Codable {
    let title, totalResults, searchTerms: String
    let count, startIndex: Int
    let inputEncoding, outputEncoding, safe, cx: String
}

// MARK: - SearchInformation
struct SearchInformation: Codable {
    let searchTime: Double
    let formattedSearchTime, totalResults, formattedTotalResults: String
}

// MARK: - URLClass
struct URLClass: Codable {
    let type, template: String
}

