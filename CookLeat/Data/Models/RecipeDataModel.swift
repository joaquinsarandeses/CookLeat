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
    var profilePicture: String?
    var category: String?
}

struct RecipeRecentDataModel: Decodable {
    var recent: [RecipeDataModel?]
}
struct UsersRecipeDataModel: Decodable {
    var id: Int?
    var name:String?
    var image: String?
    var description: String?
    var user: String?
    var profilePicture: String?
    var category: String?
}
struct MyRecipeDataModel: Decodable {
    var userRecipes: [UsersRecipeDataModel?]
    //La variable debe tener el nombre del array
}
struct OthersRecipeDataModel: Decodable {
    var id: Int?
    var name:String?
    var image: String?
    var description: String?
    var user: String?
    var profilePicture: String?
    var category: String?
}
struct OtherUserRecipeDataModel: Decodable {
    var userRecipes: [OthersRecipeDataModel?]
    //La variable debe tener el nombre del array
}


struct LikedDataModel: Decodable {
    var id: Int?
    var name:String?
    var image: String?
    var description: String?
    var user: String?
    var profilePicture: String?
    var category: String?
}
struct LikedRecipeDataModel: Decodable {
    var favorites: [LikedDataModel?]
    //La variable debe tener el nombre del array
}

struct AllRecipeDataModel: Decodable {
    var id: Int?
    var name:String?
    var image: String?
    var description: String?
    var user: String?
    var profilePicture: String?
    var category: String?
}

struct AllDataModel: Decodable {
    var list: [AllRecipeDataModel?]
}
