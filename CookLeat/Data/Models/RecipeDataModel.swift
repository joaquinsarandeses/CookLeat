//
//  RecipeDataModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 3/3/23.
//

import Foundation

struct RecipeDataModel: Decodable {
    var id: Int?
    var name:String?
    var image: String?
    var description: String?
    var user: String?
    var userPic: String?
    var category: String?
}

struct RecipeRecentDataModel: Decodable {
    var recent: [RecipeDataModel?]
}