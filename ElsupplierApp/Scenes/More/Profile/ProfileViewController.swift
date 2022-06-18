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
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_profile".localized
        viewModel.showProfile()
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
        viewModel.user.bind {
            self.updateUI(user: $0)
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func updateUI(user: UserModel) {
        userPic.setImageWith(stringUrl: user.image, placeholder: R.image.screenShot20220412At95108PM())
        username.text = user.name
        userEmail.text = user.email
    }
    
    // MARK: - Actions
    @IBAction func editClicked(_ sender: UIButton) {
        push(controller: EditProfileViewController())
    }
    
    @IBAction func myPostsClicked(_ sender: UIButton) {
        push(controller: MyPostsViewController())
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
    }
}
