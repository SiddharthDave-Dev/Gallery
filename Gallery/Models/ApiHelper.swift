//
//  ApiHelper.swift
//  Gallery
//
//  Created by Siddharth Dave on 16/09/23.
//

import Foundation


class ApiHelper {
    
    static let sharedInstances = ApiHelper()
    
    func fetchPhoto(searchText: String , completion: @escaping (ApiModel)->Void) {
        
        guard let url = ApiUrl.shared.baseUrl else {
            return
        }
        var queries : [URLQueryItem] = []
        
        queries = [URLQueryItem(name: "query", value: searchText) , URLQueryItem(name: "client_id", value: ApiUrl.shared.client_id)]
        
        let queryUrl = url.appending(queryItems: queries)
        
        print(queryUrl)
        
        let task = URLSession.shared.dataTask(with: queryUrl) { data, response, error in
            if let error = error {
                print("Network error: \(error)")
                // Handle the error, return or call the completion handler with an error.
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let res = try decoder.decode(ApiModel.self, from: data)
                    completion(res)
                } catch {
                    print("JSON decoding error: \(error)")
                    // Handle JSON decoding error, return or call the completion handler with an error.
                }
            } else {
                print("Data is missing or empty.")
                // Handle the case where data is missing or empty, return or call the completion handler with an error.
            }
        }
        task.resume()

    }
}
