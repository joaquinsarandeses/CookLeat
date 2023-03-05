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
}

struct FolowersListDataModel: Decodable {
    var followers: [FollowersDataModel?]
}
