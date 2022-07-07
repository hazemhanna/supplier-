//
//  PostsViewModel.swift
//  ElsupplierApp
//
//  Created by MAC on 16/06/2022.
//

import RxCocoa
import RxSwift
import Foundation
import UIKit

class PostsViewModel: BaseViewModel {
    
    // MARK: - Profile
    var succeeded = PublishRelay<String>()
    var messageSent = PublishRelay<Bool>()
    var user = PublishRelay<UserModel>()
    var posts = PublishRelay<[PostModel]>()

    // MARK: - Variables
    let postsApis = PostAPIs()

    // MARK: - Functions
    func loadAllPosts() {
        isLoading.accept(true)
        postsApis.loadAllPosts().subscribe { [weak self] posts in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.posts.accept(posts)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }

    func loadMyPosts() {
        isLoading.accept(true)
        postsApis.loadMyPosts().subscribe { [weak self] posts in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.posts.accept(posts)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }

    func addComment(postId: Int,comment : String) {
        isLoading.accept(true)
        postsApis.addComment(postId: postId, comment: comment).subscribe { [weak self] message in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.succeeded.accept(message)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func addPost(body: String, images: [Attachment]?) {
        isLoading.accept(true)
        postsApis.addPost(body: body, attachments: images).subscribe { [weak self] message in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.succeeded.accept(message)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func likePost(postId: Int) {
        isLoading.accept(true)
        postsApis.likePost(postId: postId).subscribe { [weak self] message in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.succeeded.accept(message)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }

    func showProfile() {
        isLoading.accept(true)
        let profileApis = ProfileAPIs()
        profileApis.showProfile().subscribe { [weak self] user in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.user.accept(user)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func sendMessage(supplierId: Int, message: String) {
         isLoading.accept(true)
        let supplierApis = SupplierAPIs()
        supplierApis.messageRequest(supplierId: supplierId, message: message).subscribe { [weak self] _ in
            self?.isLoading.accept(false)
            self?.messageSent.accept(true)
        } onError: { [weak self] in
            self?.isLoading.accept(false)
            self?.error.accept($0)
        }.disposed(by: disposeBag)
    }
}
