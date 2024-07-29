//
//  MovieSearch.swift
//  MovieDirectory
//
//  Created by Dhritanshu Aggarwal on 27/07/24.
//

import Foundation


struct MovieSearch: Decodable {
    var search: [Movie]?
    let errorMessage: String?
    private let responseString: String
    let totalResultsString: String?

    enum CodingKeys: String, CodingKey {
        case responseString = "Response"
        case search = "Search"
        case errorMessage = "Error"
        case totalResultsString = "totalResults"
    }
}
