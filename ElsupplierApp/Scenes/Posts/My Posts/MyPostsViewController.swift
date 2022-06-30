//
//  MyPostsViewController.swift
//  ElsupplierApp
//
//  Created by MAC on 15/06/2022.
//

import UIKit
import DropDown

class MyPostsViewController: BaseTabBarViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userView: UserSectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var arrowBtn : UIButton!
    @IBOutlet weak var titleLbl : UILabel!
    let dropDown = DropDown()

    var TypesArr = ["_allPosts".localized,"_myPosts".localized]

    // MARK: - Variables
    let viewModel = PostsViewModel()
    var posts = [PostModel](){
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Functions
    override func setupView() {
        super.setupView()
        viewModel.loadAllPosts()
        tableView.registerCell(ofType: MyPostsTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        userView.delegate = self
        navigationController?.navigationBar.isHidden = true
        tabBarController?.navigationController?.navigationBar.isHidden = true
        if UserModel.current != nil {
           // userView.userPic.setImageWith(stringUrl: user.image, placeholder: R.image.appLogo())
            viewModel.showProfile()

        }
        SetupDropDown()
    }
    
    @IBAction func StatusBtn(_ sender: Any) {
        dropDown.show()
    }
    
    func SetupDropDown() {
        dropDown.anchorView = arrowBtn
        dropDown.dataSource = TypesArr
        dropDown.selectionAction = {[weak self] (index, item) in
            self?.titleLbl.text =  item
            if index == 0 {
                self?.viewModel.loadAllPosts()
            }else{
                self?.viewModel.loadMyPosts()
            }
        }
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.width = 277
    }
    
    override func shouldShowNavigation() -> Bool {
        false
    }

    override func tabBarItemTitle() -> String? {
        "Posts".localized
    }
    
    override func tabBarItemImage() -> UIImage? {
        R.image.posts()
    }
    
    override func tabBarItemSelectedImage() -> UIImage? {
        R.image.postsActive()
    }
    
    override func shouldShowTabBar() -> Bool {
        true
    }
    
    override func bindViewModelToViews() {
        viewModel.isLoading.bind {
            if $0 {
                Hud.show()
            } else {
                Hud.hide()
            }
        }.disposed(by: disposeBag)
    }
    
    
    override func setupCallbacks() {
        viewModel.posts.bind { post in
            self.posts = post
        }.disposed(by: disposeBag)
        
        viewModel.succeeded.bind {  message in
            Alert.show(message: message)
        }.disposed(by: disposeBag)
        
        viewModel.user.bind {
            self.updateUI(user: $0)
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func addPostClicked(_ sender: UIButton) {
        push(controller: AddPostsViewController())
    }
    func updateUI(user: UserModel) {
        self.userView.userPic.setImageWith(stringUrl: user.image, placeholder: R.image.appLogo())
    }
    
}

extension MyPostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyPostsTableViewCell = tableView.dequeueReusableCell()!
        cell.post = posts[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension MyPostsViewController: UserSectionViewDelegate {
    func didTapNotifications() {
        push(controller: NotificationsViewController())
    }
    
    func didTapProfile() {
        push(controller: ProfileViewController())
    }
    
    func didTapSearch() {
        push(controller: SearchFilterViewController())
    }
}

extension MyPostsViewController: MyPostsTableViewCellDelegate {
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
