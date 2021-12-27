//
//  UserProfileViewModel.swift
//  ProfileCard
//
//  Created by Ha Sab on 27.12.2021.
//

import Foundation

class UserProfileViewModel {
  
  private(set) var firstName: String!
  private(set) var lastName: String!
  
  private var apiService: APIService!
  
  private var user : User? {
    didSet {
      firstName = "\(user?.name.title ?? "") \(user?.name.first ?? "")"
      lastName = user?.name.last ?? ""
      didChangeOnMainThread {}
    }
  }
  
  var onDataUpdate: (()->())?
  
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
  
  private func didChangeOnMainThread(block: @escaping (() -> Void)) {
    DispatchQueue.main.async { [weak self] in
      block()
      self?.onDataUpdate?()
    }
  }
}
