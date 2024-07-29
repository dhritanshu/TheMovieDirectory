//
//  MovieDetailViewModel.swift
//  MovieDirectory
//
//  Created by Dhritanshu Aggarwal on 28/07/24.
//

import Foundation

class MovieDetailViewModel {
    
    var model: MovieDetails?
    var detailsList: [DetailItem] = []
    // closures to inform the view about fetched data
    var movieDetailsFetched: (() -> Void)?
    var movieDetailsNotFetched: ((String?) -> Void)?
    
    func fetchDetailsById(id: String) {
        var urlString = Constants.moviesBaseUrl
        
        let paramDictionary: [String: Any] = ["apikey" : Constants.apiKey,
                                              "i": id,
                                              "plot": "full"
        ]
        
        urlString = UrlStringCreator.buildUrlWith(urlStr: urlString, param: paramDictionary) ?? ""
        
        let completionHandler: ((MovieDetails?, Error?) -> Void) = { [weak self] response, error in
            
            if let _ = error {
                self?.movieDetailsNotFetched?("Error fetching details. Please try later")
                return
            }
            
            guard let result = response
            else {
                self?.movieDetailsNotFetched?("Error fetching details. Please try later")
                return
            }
            
            self?.model = result
            
            if let list = self?.model?.createMovieDetails() {
                self?.detailsList = list
            }

            self?.movieDetailsFetched?()
        }
        
        APIManager.shared.fetch(urlString: urlString, completionHandler: completionHandler)
    }
}
