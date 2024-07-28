//
//  Constants.swift
//  MovieDirectory
//
//  Created by Dhritanshu Aggarwal on 26/07/24.
//

import Foundation

struct Constants {
    static let apiKey: String = "372a0b95"
    static let moviesBaseUrl: String = "http://www.omdbapi.com/"
    static let posterBaseUrl: String = "http://img.omdbapi.com/"
    
    
}

enum UrlType {
    case movieSearch
    case moviePoster
}

//struct UrlConstants {
//    static let search = ""
//}

struct UrlStringCreator {
//    func urlFor(type: UrlType) -> String {
//         
//            var url = Constants.moviesBaseUrl
//            
//            switch type {
//                
//            case .movieSearch:
//                break
//            case .moviePoster:
//                break
//            }
//            
//            return url
//        }
        
        static func buildUrlWith(urlStr: String, param: [String: Any]) -> String? {
            var finalUrl = urlStr
            var count = 0
            if !urlStr.isEmpty && param.keys.count > 0 {
                for key in param.keys {
                    if count == 0 {
                        if let value = param[key] {
                            finalUrl += "?\(key)=\(value)"
                        }
                    } else {
                        
                        if let value = param[key] {
                            finalUrl += "&\(key)=\(value)"
                        }
                    }
                    
                    count = count + 1
                }
                return finalUrl
            }
            return nil
        }
}
