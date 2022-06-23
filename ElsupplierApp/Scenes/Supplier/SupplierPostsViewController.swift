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
    let posts: [PostModel]
    
    // MARK: - Life Cycle
    init(posts: [PostModel]) {
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
    
    // MARK: - Actions

}

extension SupplierPostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { posts.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyPostsTableViewCell = tableView.dequeueReusableCell()!
        cell.post = posts[indexPath.row]
        return cell
    }
}

extension SupplierPostsViewController: MyPostsTableViewCellDelegate {
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, didLike item: PostModel) {
        viewModel.likePost(postId: item.id)
    }
    
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, didAddComent item: PostModel,comment : String) {
        viewModel.addComment(postId: item.id, comment: comment)
    }
    
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, sendMessage item: PostModel) {
        
    }
    
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, makeCall item: PostModel) {
        
    }
    
}
