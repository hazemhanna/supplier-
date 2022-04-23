//
//  CommentModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 22/04/2022.
//

import ObjectMapper

final class CommentModel: BaseObject {
    
    var userId = 0
    var postId = 0
    var comment = ""
    var createdAt = ""
    var updatedAt = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        userId <- map["user_id"]
        postId <- map["post_id"]
        comment <- map["comment"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
    }
    
}
