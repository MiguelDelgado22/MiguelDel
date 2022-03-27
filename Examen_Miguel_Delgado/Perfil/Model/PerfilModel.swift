//
//  PerfilModel.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 25/03/22.
//

import Foundation

struct PerfilModel: Codable {
  let avatar: Gravatar
  let id: Int
  let name: String?
  let username: String
}

struct Gravatar: Codable {
  let gravatar: Hash
  let tmdb: Tmdba
}

struct Hash: Codable {
  let hash: String
}

struct Tmdba: Codable {
  let avatar_path: String
}

