//
//  EditProfileViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 15/04/2022.
//

import UIKit

class EditProfileViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var mobileNoTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var activityTypeTF: UITextField!
    @IBOutlet weak var companyNameTF: UITextField!
    
    // MARK: - Variables
    let viewModel = ProfileViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_personal_info".localized
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
        viewModel.updatedSuccessfully.bind { _ in
            Alert.show(message: "Updated successfully")
        }.disposed(by: disposeBag)
        
        viewModel.error.bind { error in
            Alert.show(message: error.localizedDescription)
        }.disposed(by: disposeBag)
        
        viewModel.areas.bind { areas in
            self.showAreas(areas: areas)
        }.disposed(by: disposeBag)
        
        viewModel.activities.bind { activities in
            self.showActivities(activities: activities)
        }.disposed(by: disposeBag)
    }
    
    func showActivities(activities: [UserTypeModel]) {
        ActionSheet.show(title: "Select Activity", cancelTitle: "Cancel", otherTitles: activities.map({ $0.name }), sender: activityTypeTF) {[weak self] index in
            guard let self = self else { return }
            if index != 0 {
                self.activityTypeTF.text = activities[index - 1].name
                self.viewModel.activityTypeSelected.accept(activities[index - 1].id)
            }
        }
    }
    
    func showAreas(areas: [PickerModel]) {
        ActionSheet.show(title: "Select City", cancelTitle: "Cancel", otherTitles: areas.map({ $0.name }), sender: cityTF) {[weak self] index in
            guard let self = self else { return }
            if index != 0 {
                self.cityTF.text = areas[index - 1].name
                self.viewModel.areaId.accept(areas[index - 1].id)
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func saveChangesClicked(_ sender: UIButton) {
        viewModel.updateProfile()
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == cityTF {
            viewModel.loadAreas()
        } else if textField == activityTypeTF {
            viewModel.loadActivityTypes()
        }
        return false
    }
    
}
