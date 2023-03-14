//
//  UserDataModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 2/3/23.
//

import Foundation

struct UserDataModel: Decodable {
    var id: Int?
    var name:String?
    var image: String?
    var followers: Int?
    var follows: Int?
}

