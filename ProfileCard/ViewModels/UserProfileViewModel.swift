//
//  UserProfileViewModel.swift
//  ProfileCard
//
//  Created by Ha Sab on 27.12.2021.
//

import UIKit

class UserProfileViewModel {
  
  private(set) var firstName: String!
  private(set) var lastName: String!
  
  private(set) var email: String!
  private(set) var cell: String!
  private(set) var location: String!
  
  private(set) var image: UIImage!
  
  private var user : User? {
    didSet {
      guard let user = user else { return }
      firstName = "\(user.name.title) \(user.name.first)"
      lastName = user.name.last
      email = user.email
      cell = user.cell
      location = "\(user.location.street.number) \(user.location.street.name), \(user.location.city)"
      getImage(urlString: user.picture.large) { [weak self] image in
        self?.image = image
        self?.didChangeOnMainThread {}
      }
    }
  }
  
  private let apiService: APIService!
  
  var onDataUpdate: (() -> ())?
  
  init() {
    apiService = APIService()
    fetchUserData()
  }
  
  func updateUserData() {
    fetchUserData()
  }
  
  private func fetchUserData() {
    apiService.getUserData { user in
      if let user = user {
        self.user = user
      }
    }
  }
  
  private func getImage(urlString: String, completion: @escaping (UIImage) -> ()) {
    apiService.getImage(from: urlString) { image in
      completion(image ?? UIImage())
    }
  }
  
  private func didChangeOnMainThread(block: @escaping () -> ()) {
    DispatchQueue.main.async { [weak self] in
      block()
      self?.onDataUpdate?()
    }
  }
}
