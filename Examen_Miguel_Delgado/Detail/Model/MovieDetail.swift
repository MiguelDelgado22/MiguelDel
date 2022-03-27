//
//  MovieDetail.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 12/03/22.
//

import Foundation

struct MovieDetail: Codable {
  let title: String
  let imageMovie: String
  let overview: String
  let popularity: Double
  let status: String
  let tagline: String
  let prductionCompanies: [Production]?
  
  enum CodingKeys: String, CodingKey {
    case title
    case imageMovie = "backdrop_path"
    case overview
    case popularity
    case status
    case tagline
    case prductionCompanies = "production_companies"
  }
}

struct Production: Codable {
  let id: Int?
  let logoPath: String?
  let name: String?
  let origin_country: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case logoPath = "logo_path"
    case name
    case origin_country
  }
}

struct FavoriteModel {
  var isFavorite: Bool
  var title: String
  var image: String
  var date: String
  var descriptionaImage: String
  var favorite: Double
  
  
}
