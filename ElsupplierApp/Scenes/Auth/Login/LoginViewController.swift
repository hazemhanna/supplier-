//
//  LoginViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 08/04/2022.
//

import UIKit
import RxSwift

class LoginViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var mobileNoTF: UITextField!
    
    // MARK: - Variables
    let viewModel = LoginViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
    }
    
    override func shouldShowTopView() -> Bool {
        false
    }
    
    override func bindViewsToViewModel() {
        mobileNoTF.rx.text
            .orEmpty
            .bind(to: viewModel.mobileNo).disposed(by: disposeBag)
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
            $0.store()
            UIApplication.initWindow()
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func loginClicked(_ sender: UIButton) {
        viewModel.login()
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        push(controller: RegisterViewController())
    }
    
    @IBAction func downloadSupplierAppClicked(_ sender: UIButton) {
    }
}