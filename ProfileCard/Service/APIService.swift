//
//  APIService.swift
//  ProfileCard
//
//  Created by Ha Sab on 27.12.2021.
//

import Foundation

class APIService {
  
  private let url = URL(string: "https://randomuser.me/api/")
  
  func getUserData(completion : @escaping (User?) -> Void) {
    guard let url = url else {
      completion(nil)
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No data")
        completion(nil)
        return
      }
      guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
        print("Unknown error")
        completion(nil)
        return
      }
      
      do {
        let results = try JSONSerialization.jsonObject(with: data) as! [String:Any]
        let usersData = try JSONSerialization.data(withJSONObject: results["results"] as Any)
        let users = try JSONDecoder().decode([User].self, from: usersData)
        completion(users.first)
      } catch {
        print(error.localizedDescription)
        completion(nil)
      }
      
    }.resume()
  }
}
