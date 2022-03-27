//
//  ManagerConnections.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 10/03/22.
//

import Foundation
import RxSwift

class ManagerConnection {
  
  
  func managerToken(_ endPoint: String, changeURL: Bool = false, method: String, parameters: [String: String], urlWithSession: Bool = false, completion: @escaping (Data?, String?) -> Void) {
    let session = URLSession.shared
    var request: URLRequest!
    
    if changeURL {
      request = URLRequest(url: URL(string: "https://www.themoviedb.org/authenticate/\(endPoint)?redirect_to=http://www.Examen_Miguel_Delgado.com/approved")!)
    } else {
      
      if urlWithSession {
        let session = "&session_id=\(LoginInteractor.shared.session)"
        request = URLRequest(url: URL(string: Constants.URL.main+endPoint+Constants.apiKey+session)!)
      } else {
        request = URLRequest(url: URL(string: Constants.URL.main+endPoint+Constants.apiKey)!)
      }
    }
    
    
    request.httpMethod = method
    
    do {
      // convert parameters to Data and assign dictionary to httpBody of request
      if !parameters.isEmpty {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      }
    } catch let error {
      print(error.localizedDescription)
      return
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    session.dataTask(with: request) { (data, response, error) in
      guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
        completion(nil, error.debugDescription)
        return
      }
      if response.statusCode == 200 {
        completion(data, nil)
      } else if response.statusCode == 401 {
        completion(data, nil)
      }
      
      else {
        completion(nil,"Campos obligatorios")
      }
    }.resume()
  }
  
  func managerConnection<T: Decodable>(endPoint: String, urlWithSession: Bool = false, parameters: [String: String], method: String = "GET") -> Observable<T> {
    return Observable.create { observer in
      let session = URLSession.shared
      var request: URLRequest!
      
      if urlWithSession {
        let session = "&session_id=\(LoginInteractor.shared.session)"
        request = URLRequest(url: URL(string: Constants.URL.main+endPoint+Constants.apiKey+session)!)
      } else {
        request = URLRequest(url: URL(string: Constants.URL.main+endPoint+Constants.apiKey)!)
      }
      
      
      
      request.httpMethod = method
      
      
      if !parameters.isEmpty {
        do {
          // convert parameters to Data and assign dictionary to httpBody of request
          request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
          print(error.localizedDescription)
          observer.onError(error)
        }
      }
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      session.dataTask(with: request) { (data, response, error) in
        guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
        switch response.statusCode {
        case 200:
          do {
            let json = try JSONDecoder().decode(T.self, from: data)
            observer.onNext(json)
          } catch let error {
            observer.onError(error)
          }
        case 401:
          observer.onError(error?.localizedDescription as! Error)
        default:
          break
        }
        observer.onCompleted()
      }.resume()
      return Disposables.create {
        session.finishTasksAndInvalidate()
      }
    }
  }
}
