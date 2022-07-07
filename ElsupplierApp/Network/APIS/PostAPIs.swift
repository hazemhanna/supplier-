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
    
    func addPost(body: String, attachments: [Attachment]?) -> Single<String> {
        let request = ESNetworkRequest("posts/store")
        request.method = .post
        request.parameters = ["body": body]
        var files = [MPFile]()
        attachments?.forEach { photo  in
            if let data = photo.data {
                files.append(.init(data: data, key: "media[]", name: "media." + photo.ext!, memType: photo.mimeType ?? ""))
            }
        }
        request.selections = [.key("message")]
        return NetworkManager.upload(data: .multipart(files), request: request) { progress in
            debugPrint("progress: \(progress)")
        }
    }
    
}

struct Attachment {
    let data: Data?
    let mimeType: String?
    let ext: String?
}
