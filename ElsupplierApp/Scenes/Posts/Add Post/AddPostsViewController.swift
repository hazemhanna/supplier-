//
//  AddPostsViewController.swift
//  ElsupplierApp
//
//  Created by MAC on 15/06/2022.
//

import UIKit

class AddPostsViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var postTf: UITextField!

    // MARK: - Variables
    let viewModel = PostsViewModel()
    var attachments:[UIImage] = []

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_addPost".localized
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
        viewModel.succeeded.bind { model in
            Alert.show(title: model, message: nil, cancelTitle: "Ok", otherTitles: []) { _ in
                self.pop()
            }
        }.disposed(by: disposeBag)
        
        viewModel.error.bind { error in
            Alert.show(message: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func addPostClicked(_ sender: UIButton) {
        viewModel.addPost(title: "", body: "", images: attachments)
    }
    
    @IBAction func uploadLogoClicked(_ sender: UIButton) {
        ImagePicker.pickImage(sender: sender) { [weak self] image in
            guard let image = image else { return }
            self?.attachments.append(image)
        }
    }
    
}
