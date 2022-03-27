//
//  MoviePopular.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 11/03/22.
//

import Foundation

struct MoviesPopular: Codable {
  let page: Int
  let movies: [MoviePopular]
  
  enum CodingKeys: String, CodingKey {
    case page = "page"
    case movies = "results"
  }
}

struct MoviePopular: Codable {
  let id: Int
  let posterPath: String
  let description: String
  let releaseDate: String
  let title: String
  let voteAverage: Double
  
  enum CodingKeys: String, CodingKey {
    case id
    case posterPath = "poster_path"
    case description = "overview"
    case releaseDate = "release_date"
    case title = "original_title"
    case voteAverage = "vote_average"
  }
}

