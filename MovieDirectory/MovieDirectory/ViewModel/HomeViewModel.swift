//
//  HomeViewModel.swift
//  MovieDirectory
//
//  Created by Dhritanshu Aggarwal on 27/07/24.
//

import Foundation

class HomeViewModel {
    
    var model: MovieSearch?
    
    private var page: Int = 0
    
    var moviesFetched: (() -> Void)?
    var moviesNotFetched: ((Error?) -> Void)?
    
    func fetchData(keyWord: String) {

        var urlString = Constants.moviesBaseUrl
        
        if let list = model?.search {
            let countString = String(list.count)
            //if all the results for a keyword are fetched then no need to make extra api calls
            if (self.model?.totalResultsString == countString) {
                return
            }
        }
        
        page += 1
        
        let paramDictionary: [String: Any] = ["apikey" : Constants.apiKey,
                                              "s": keyWord,
                                              "page": page
        ]
        
        urlString = UrlStringCreator.buildUrlWith(urlStr: urlString, param: paramDictionary) ?? ""
        
        let completionHandler: ((MovieSearch?, Error?) -> Void) = { [weak self] response, error in
            if let error = error {
                self?.moviesNotFetched?(error)
                self?.page = 1
                return
            }
            
            guard let result = response,
                  var films = result.search,
                  films.count > 0
            else {
                self?.moviesNotFetched?(error)
                self?.page = 1
                return
            }
            
            if let existingList = self?.model?.search {
                films = existingList + films
            }
            
            self?.model = result
            self?.model?.search = films
           
            self?.moviesFetched?()
        }
        
        APIManager.shared.fetch(urlString: urlString, completionHandler: completionHandler) 
    }
}
