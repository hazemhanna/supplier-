//
//  PostModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 22/04/2022.
//

import ObjectMapper

final class PostModel: BaseObject {
    
    var route = ""
    var postOwner = ""
    var postOwnerRole = ""
    var postOwnerImage = ""
    var ownerId = 0
    var ownerLiked = 0
    var title = ""
    var body = ""
    var link = ""
    var postDate = ""
    var isLiked = 0
    var likesCount = 0
    var impressionsCount = 0
    var commentCount = 0
    var comments: [CommentModel] = []
    var media: [String] = []
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        route <- map["route"]
        postOwner <- map["post_owner"]
        postOwnerRole <- map["post_owner_role"]
        postOwnerImage <- map["post_owner_image"]
        ownerId <- map["owner_id"]
        ownerLiked <- map["owner_liked"]
        title <- map["title"]
        body <- map["body"]
        link <- map["link"]
        postDate <- map["post_date"]
        isLiked <- map["is_liked"]
        likesCount <- map["likesCount"]
        impressionsCount <- map["impressionsCount"]
        commentCount <- map["commentCount"]
        comments <- map["comments"]
        media <- map["media"]
    }
    
}
