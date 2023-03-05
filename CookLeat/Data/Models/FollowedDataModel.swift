//
//  FollowedDataModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 5/3/23.
//

import Foundation

struct FollowedDataModel: Decodable {
    var id: Int?
    var name:String?
    var image: String?
}
struct FolowedListDataModel: Decodable {
    var followers: [FollowedDataModel?]
}
