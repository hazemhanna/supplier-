//
//  SupplierPostsViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 11/06/2022.
//

import UIKit

class SupplierPostsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let viewModel = PostsViewModel()
    let supplierViewModel = SupplierViewModel()
    let posts: [PostModel]
    let supplier: SupplierModel
    
    // MARK: - Life Cycle
    init(supplier: SupplierModel, posts: [PostModel]) {
        self.supplier = supplier
        self.posts = posts
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        tableView.registerCell(ofType: MyPostsTableViewCell.self)
    }
    
    override func setupCallbacks() {
        viewModel.isLoading.bind {
            if $0 {
                Hud.show()
            } else {
                Hud.hide()
            }
        }.disposed(by: disposeBag)
        
        viewModel.succeeded.bind { str in
            Alert.show(message: str)
        }.disposed(by: disposeBag)
        
        supplierViewModel.isLoading.bind {
            if $0 {
                Hud.show()
            } else {
                Hud.hide()
            }
        }.disposed(by: disposeBag)
        
        supplierViewModel.callbackRequested.bind { _ in
            Alert.show(message: "_request_call_succeed")
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions

}

extension SupplierPostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { posts.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyPostsTableViewCell = tableView.dequeueReusableCell()!
        cell.post = posts[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension SupplierPostsViewController: MyPostsTableViewCellDelegate {
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, didLike item: PostModel) {
        viewModel.likePost(postId: item.id)
        item.isLiked = item.isLiked == 1 ? 0 : 1
        cell.likeBtn.isSelected = item.isLiked == 1
    }
    
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, didAddComent item: PostModel,comment : String) {
        viewModel.addComment(postId: item.id, comment: comment)
    }
    
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, sendMessage item: PostModel) {
        
    }
    
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, makeCall item: PostModel) {
        supplierViewModel.requestCallBack(supplierId: supplier.id)
    }
    
}
