//
//  PostView-ViewModel.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 6/3/23.
//

import Foundation

extension PostView{
    
    class ViewModel{
        
        var name: String
        var image: String
        var description: String
        var user: String
        var userPic: String
        var category: String
        
        init() {
            self.name = ""
            self.image = ""
            self.description = ""
            self.user = ""
            self.userPic = ""
            self.category = ""
        }
        
        init(like: LikePresentationModel) {
            self.name = like.name
            self.image = like.image
            self.description = like.description
            self.user = like.user
            self.userPic = like.userPic
            self.category = like.category
        }

        init(recent: RecentPresentationModel) {
            self.name = recent.name
            self.image = recent.image
            self.description = recent.description
            self.user = recent.user
            self.userPic = recent.profilePicture
            self.category = recent.category
        }
        init(event: MyEventsPresentationModel) {
            self.name = event.name
            self.image = event.image
            self.description = event.description
            self.user = event.user
            self.userPic = event.userPic
            self.category = event.category
        }
        
        init(allSearch: AllPresentationModel) {
            self.name = allSearch.name
            self.image = allSearch.image
            self.description = allSearch.description
            self.user = allSearch.user
            self.userPic = allSearch.userPic
            self.category = allSearch.category
        }
        init(otherPost: OthersEventsPresentationModel) {
            self.name = otherPost.name
            self.image = otherPost.image
            self.description = otherPost.description
            self.user = otherPost.user
            self.userPic = otherPost.userPic
            self.category = otherPost.category
        }
        
    }
    
}
