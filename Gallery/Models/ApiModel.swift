//
//  ApiModel.swift
//  Gallery
//
//  Created by Siddharth Dave on 16/09/23.
//

import Foundation


struct ApiModel : Codable {
    
    let total : Int?
    let total_pages : Int?
    let results : [Result]
}

struct Result : Codable {
    let id : String?
    let urls : URLS
//    let tags : [Tags]
}

struct URLS : Codable {
    let regular : String?
}

//struct Tags : Codable {
//    let source : Sources
//}
//
//struct Sources : Codable {
//    let cover_photo : UrlTags
//}
//
//struct UrlTags : Codable {
//    let urls : Url
//}
//
//struct Url : Codable {
//    let regular : String?
//}
