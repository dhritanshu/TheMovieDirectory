//
//  HomeViewModel.swift
//  MovieDirectory
//
//  Created by Dhritanshu Aggarwal on 27/07/24.
//

import Foundation

class HomeViewModel {
    
    var model: MovieSearch?
    
    // closures to inform the view about fetched data
    var moviesFetched: (() -> Void)?
    var moviesNotFetched: ((String?) -> Void)?
    
    private var page: Int = 0
    
    func fetchData(keyWord: String) {
        
        var urlString = Constants.moviesBaseUrl
        
        if let list = model?.search {
            let countString = String(list.count)
            // if all the results for a keyword are fetched then no need to make extra api calls
            // tried and tested with keyword 'the hangover'
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
            if let _ = error {
                self?.moviesNotFetched?(error?.localizedDescription ?? "Error fetching results. Please try later")
                self?.page = 0
                return
            }
            
            guard let result = response,
                  var films = result.search,
                  films.count > 0
            else {
                self?.moviesNotFetched?(response?.errorMessage)
                self?.page = 0
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
