//
//  ProfileViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 15/04/2022.
//

import UIKit

class ProfileViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    // MARK: - Variables
    let viewModel = ProfileViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        viewModel.showProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_profile".localized
    }
    
    override func bindViewModelToViews() {
        viewModel.isLoading.bind {
            Hud.showDismiss($0)
        }.disposed(by: disposeBag)
    }
    
    override func setupCallbacks() {
        viewModel.user.bind {
            if let user = UserModel.current {
                user.image = $0.image
                user.store()
            }
            self.updateUI(user: $0)
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
    }
    func updateUI(user: UserModel) {
        userPic.setImageWith(stringUrl: user.image, placeholder: R.image.appLogo())
        username.text = user.name
        userEmail.text = user.email
    }
    
    // MARK: - Actions
    @IBAction func editClicked(_ sender: UIButton) {
        push(controller: EditProfileViewController())
    }
    
    @IBAction func myPostsClicked(_ sender: UIButton) {
        push(controller: MyPostsViewController(selectedType: 1))
    }
    
    @IBAction func messagesClicked(_ sender: UIButton) {
        push(controller: MessagesViewController())
    }

    @IBAction func myOrdersClicked(_ sender: UIButton) {
        push(controller: MyOrdersViewController())
    }

    @IBAction func myAddressesClicked(_ sender: UIButton) {
        push(controller: AddressesListViewController())
    }

    @IBAction func paymentWaysClicked(_ sender: UIButton) {
    }

    @IBAction func myTendersClicked(_ sender: UIButton) {
        push(controller: TendersViewController())
    }

    @IBAction func favProductsClicked(_ sender: UIButton) {
        push(controller: FavProductsViewController())
    }

    @IBAction func favSuppliersClicked(_ sender: UIButton) {
        push(controller: FavoriteSuppliersViewController())
    }
    
    @IBAction func logoutClicked(_ sender: UIButton) {
        UserModel.current = nil
        viewModel.logout()
        push(controller: LoginViewController())
    }
}
