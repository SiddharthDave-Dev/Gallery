//
//  ApiUrl.swift
//  Gallery
//
//  Created by Siddharth Dave on 16/09/23.
//

import Foundation


class ApiUrl {
    
    static let shared = ApiUrl()
    
    let client_id = "Co2EBtDDxOnr8mMhdOwX3pIRhRnrFxIYxs5IcX-OCf0"
    
    let baseUrl = URL(string: "https://api.unsplash.com/search/photos?page=all")
}
