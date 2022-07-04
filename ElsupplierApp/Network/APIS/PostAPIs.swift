//
//  PostAPIs.swift
//  ElsupplierApp
//
//  Created by MAC on 16/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import ESNetworkManager

final class PostAPIs {
    
    func loadAllPosts() -> Single<[PostModel]> {
        let request = ESNetworkRequest("posts/all-posts")
        request.selections = [.key("data"), .key("all_posts")]
        return NetworkManager.execute(request: request)
    }
    
    func loadMyPosts() -> Single<[PostModel]> {
        let request = ESNetworkRequest("posts/my-posts")
        request.selections = [.key("data"), .key("my_posts")]
        return NetworkManager.execute(request: request)
    }
    
    func likePost(postId: Int) -> Single<String> {
        let request = ESNetworkRequest("posts/like")
        request.method = .post
        request.parameters = ["postId": postId]
        request.selections = [.key("message")]
        return NetworkManager.execute(request: request)
    }
    
    func addComment(postId: Int, comment : String) -> Single<String> {
        let request = ESNetworkRequest("posts/add/comment")
        request.method = .post
        request.parameters = ["postId": postId,
                              "comment": comment]
        request.selections = [.key("message")]
        return NetworkManager.execute(request: request)
    }
    
    func addPost(title: String, body: String, attachments: [UIImage]?) -> Single<String> {
        let request = ESNetworkRequest("posts/store")
        request.method = .post
        request.parameters = ["title": title,
                              "body": body]
        var files = [MPFile]()
        attachments?.forEach { photo  in
            if let data = photo.jpegData(compressionQuality: 0.5){
                files.append(.init(data: data, key: "media[]", name: "media", memType: "Jpeg"))
            }
        }
        request.selections = [.key("message")]
        return NetworkManager.upload(data: .multipart(files), request: request) { progress in
        }
    }
    
    

    
}
