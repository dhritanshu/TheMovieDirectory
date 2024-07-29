//
//  APIManager.swift
//  MovieDirectory
//
//  Created by Dhritanshu Aggarwal on 26/07/24.
//

import Foundation

typealias CompletionHandler<T> = ((_ viewModel: T?, _ error: Error?) -> Void)

class APIManager: NSObject {
    
    static let shared = APIManager()
    
    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5.0
        configuration.timeoutIntervalForResource = 5.0
        super.init()
    }
    
    func fetch<T: Decodable>(urlString: String, completionHandler: @escaping CompletionHandler<T>) {
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(nil, error)
                return
            }
            
            if let data = data {
                let result = try? JSONDecoder().decode(T.self, from: data)
                completionHandler(result, nil)
            }
        }.resume()
        
    }
    
}

struct UrlStringCreator {
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
