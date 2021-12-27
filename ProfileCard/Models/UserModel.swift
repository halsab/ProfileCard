//
//  UserModel.swift
//  ProfileCard
//
//  Created by Ha Sab on 27.12.2021.
//

import Foundation

// MARK: - User Model

struct User: Decodable {
  let name: UserName
  let location: UserLocation
  let email: String
  let cell: String
  let picture: UserPicture
  
  struct UserName: Decodable {
    let title: String
    let first: String
    let last: String
  }

  struct UserLocation: Decodable {
    let street: Street
    let city: String
    let country: String

    struct Street: Decodable {
      let number: Int
      let name: String
    }
  }

  struct UserPicture: Decodable {
    let medium: String
  }
}

// MARK: - Test Example User

extension User {
  static let testUser = User(name: UserName(title: "Mr", first: "Clifford", last: "Mcguinness"),
                             location: UserLocation(street: UserLocation.Street(number: 697, name: "Church Lane"), city: "Buncrana", country: "Ireland"),
                             email: "clifford.mcguinness@example.com",
                             cell: "081-263-0533",
                             picture: UserPicture(medium: "https://randomuser.me/api/portraits/med/men/70.jpg"))
}
