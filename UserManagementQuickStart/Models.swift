//
//  Models.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/4/24.
//

import Foundation

struct Profile: Codable {
  let username: String?
  let fullName: String?
  let website: String?
  let avatarURL: String?
    let count: Int?

  enum CodingKeys: String, CodingKey {
    case username
    case fullName = "full_name"
    case website
    case avatarURL = "avatar_url"
    case count
  }
}
