//
//  RegisterViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 09/04/2022.
//

import UIKit

class RegisterViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var mobileNoTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var activityTypeTF: UITextField!
    @IBOutlet weak var companyNameTF: UITextField!
    
    // MARK: - Variables
    let viewModel = RegisterViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        activityTypeTF.delegate = self
    }
    
    override func shouldShowTopView() -> Bool {
        false
    }
    
    func showActivities(activities: [UserTypeModel]) {
        ActionSheet.show(title: "Select Activity", cancelTitle: "Cancel", otherTitles: activities.map({ $0.name }), sender: activityTypeTF) {[weak self] index in
            guard let self = self else { return }
            if index != 0 {
                self.activityTypeTF.text = activities[index - 1].name
                self.viewModel.activityType.accept(activities[index - 1].id)
            }
        }
    }
    
    override func bindViewsToViewModel() {
        nameTF.rx.text
            .orEmpty
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        
        mobileNoTF.rx.text
            .orEmpty
            .bind(to: viewModel.mobileNo)
            .disposed(by: disposeBag)
        
        emailTF.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        companyNameTF.rx.text
            .orEmpty
            .bind(to: viewModel.companyName)
            .disposed(by: disposeBag)
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
        
        viewModel.activities.bind {
            self.showActivities(activities: $0)
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    override func shouldShowNavigation() -> Bool {
        false
    }
    
    // MARK: - Actions
    @IBAction func termsOfUseClicked(_ sender: UIButton) {
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        viewModel.register()
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        pop()
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        viewModel.loadActivityTypes()
        return false
    }
    
}
