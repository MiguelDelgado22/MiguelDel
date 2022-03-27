//
//  Constants.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 10/03/22.
//

import Foundation
import UIKit

struct Constants {
  static let apiKey = "?api_key=ac7b54ac34141c0d9ea13548695c57a5"
  
  struct URL {
    static let main = "https://api.themoviedb.org/3"
    static let userPermission = "https://www.themoviedb.org/authenticate/"
    static let urlImages = "https://image.tmdb.org/t/p/w200"
  }
  
  struct EndPoints {
    static let urlToken = "/authentication/token/new"
    static let login = "/authentication/token/validate_with_login"
    static let urlListPopularMovies = "/movie/popular"
    static let urlDetailMovie = "/movie/"
    static let logOut = "/authentication/session"
    static let session = "/authentication/session/new"
    static let perfil = "/account"
  }
  
  struct ImageName {
    static let imageLogin = "image_login"
  }
  
  struct ConstantsString {
    static let placeHolderUserName = "User Name"
    static let placeHolderPassword = "Password"
    static let titleActionSheet = "What do you want to do?"
    static let optionOne = "View Profile"
    static let logOut = "Log out"
  }
  
  struct ColorView {
    static let colorBackgroundCell = "#141e21"
    
  }
  
}
