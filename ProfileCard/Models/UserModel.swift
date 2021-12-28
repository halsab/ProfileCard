//
//  UserModel.swift
//  ProfileCard
//
//  Created by Ha Sab on 27.12.2021.
//

import Foundation

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
    let large: String
  }
}
