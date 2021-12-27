//
//  APIService.swift
//  ProfileCard
//
//  Created by Ha Sab on 27.12.2021.
//

import UIKit

class APIService {
  
  private static let userDataUrl = URL(string: "https://randomuser.me/api/")
  
  static func getUserData(completion : @escaping (User?) -> ()) {
    guard let url = userDataUrl else {
      completion(nil)
      return
    }
    
    getData(from: url) { data, response, error in
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
    }
  }
  
  static func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> ()) {
    guard let url = URL(string: urlString) else {
      completion(nil)
      return
    }
    print("Download Started")
    getData(from: url) { data, response, error in
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
      print(response?.suggestedFilename ?? url.lastPathComponent)
      print("Download Finished")
      completion(UIImage(data: data))
    }
  }
  
  private static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
  }
}
