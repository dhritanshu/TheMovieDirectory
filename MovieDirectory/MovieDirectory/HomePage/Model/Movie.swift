//
//  Movie.swift
//  MovieDirectory
//
//  Created by Dhritanshu Aggarwal on 28/07/24.
//

import Foundation

struct Movie: Codable {

    let title: String
    let year: String?
    let imdbId: String?
    let type: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }

}
