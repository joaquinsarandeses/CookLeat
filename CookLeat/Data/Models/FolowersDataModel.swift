//
//  FolowersDataModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 5/3/23.
//

import Foundation

struct FollowersDataModel: Decodable {
    var id: Int?
    var name:String?
    var image: String?
    var follower_count: Int?
    var followed_count: Int?
}

struct FollowersListDataModel: Decodable {
    var followers: [FollowersDataModel?]
}
