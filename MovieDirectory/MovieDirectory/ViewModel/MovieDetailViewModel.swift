//
//  MovieDetailViewModel.swift
//  MovieDirectory
//
//  Created by Dhritanshu Aggarwal on 28/07/24.
//

import Foundation

class MovieDetailViewModel {
    
    var model: MovieDetails?
    var movieDetailsFetched: (() -> Void)?
    var movieDetailsNotFetched: ((Error?) -> Void)?
    
    func fetchDetailsById(id: String) {
        var urlString = Constants.moviesBaseUrl
        
        let paramDictionary: [String: Any] = ["apikey" : Constants.apiKey,
                                              "i": id,
                                              "plot": "full"
        ]
        
        urlString = UrlStringCreator.buildUrlWith(urlStr: urlString, param: paramDictionary) ?? ""
        
        let completionHandler: ((MovieDetails?, Error?) -> Void) = { [weak self] response, error in
            
            if let error = error {
                self?.movieDetailsNotFetched?(error)
                return
            }
            
            guard let result = response
            else {
                self?.movieDetailsNotFetched?(error)
                return
            }
            
            self?.model = result

            self?.movieDetailsFetched?()
        }
        
        APIManager.shared.fetch(urlString: urlString, completionHandler: completionHandler)
    }
}
