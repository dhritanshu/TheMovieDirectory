//
//  MovieDetails.swift
//  MovieDirectory
//
//  Created by Dhritanshu Aggarwal on 26/07/24.
//

import Foundation

class MovieDetails: Codable {
    
    var detailsList: [DetailItem] = []

    let title: String
    let year: String?
    let rated: String?
    let released: String?
    let runtime: String?
    let genre: String?
    let director: String?
    let writer: String?
    let actors: String?
    let plot: String?
    let language: String?
    let country: String?
    let awards: String?
    let poster: String?
    let metascore: String?
    let imdbRating: String?
    let dvd: String?
    let boxOffice: String?
    let production: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
    }

    func createMovieDetails() -> [DetailItem] {
        detailsList = []
        
        if let director = self.director {
            detailsList.append(DetailItem(heading: "Director", detail: director))
        }
        
        if let genre = self.genre {
            detailsList.append(DetailItem(heading: "Genre", detail: genre))
        }
        
        if let plot = self.plot {
            detailsList.append(DetailItem(heading: "Plot", detail: plot))
        }
        
        if let releaseDate = self.released {
            detailsList.append(DetailItem(heading: "Release Date", detail: releaseDate))
        }
        
        if let country = self.country {
            detailsList.append(DetailItem(heading: "Country", detail: country))
        }
        
        if let actors = self.actors {
            detailsList.append(DetailItem(heading: "Actors", detail: actors))
        }
        
        if let awards = self.awards {
            detailsList.append(DetailItem(heading: "Awards", detail: awards))
        }
        
        if let imdbRating = self.imdbRating {
            detailsList.append(DetailItem(heading: "IMDb Rating", detail: imdbRating))
        }
        
        if let boxOffice = self.boxOffice {
            detailsList.append(DetailItem(heading: "Box Office Collection", detail: boxOffice))
        }
        
        return detailsList
    }
}

struct DetailItem {
    let heading: String
    let detail: String
}
