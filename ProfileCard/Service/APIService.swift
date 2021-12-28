//
//  APIService.swift
//  ProfileCard
//
//  Created by Ha Sab on 27.12.2021.
//

import UIKit

class APIService {
  
  private struct URLStrings {
    static let userData = "https://randomuser.me/api/"
  }
  
  // MARK: - Get User Data
  
  func getUserData(completion : @escaping (User?) -> ()) {
    getData(from: URLStrings.userData) { data in
      guard let data = data else {
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
    }
  }
  
  // MARK: - Download Image
  
  func getImage(from urlString: String, completion: @escaping (UIImage?) -> ()) {
    getData(from: urlString) { data in
      guard let data = data else {
        completion(nil)
        return
      }
      completion(UIImage(data: data))
    }
  }
  
  // MARK: - Private Functions
  
  private func getData(from urlString: String, completion: @escaping (Data?) -> ()) {
    guard let url = URL(string: urlString) else {
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
      completion(data)
    }.resume()
  }
}
