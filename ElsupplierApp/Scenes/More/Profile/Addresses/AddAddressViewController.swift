//
//  AddAddressViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 11/05/2022.
//

import UIKit

class AddAddressViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var governrantTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var areaTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var buildingNoTF: UITextField!
    @IBOutlet weak var floorTF: UITextField!
    @IBOutlet weak var landmarkTV: UITextView!
    @IBOutlet weak var saveButton: UIButton!

    // MARK: - Variables
    let viewModel = AddressesViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_new_address".localized
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
    
    override func bindViewsToViewModel() {
        streetTF.rx.text
            .orEmpty
            .bind(to: viewModel.street)
            .disposed(by: disposeBag)
        
        buildingNoTF.rx.text
            .orEmpty
            .bind(to: viewModel.buildingNo)
            .disposed(by: disposeBag)
        
        floorTF.rx.text
            .orEmpty
            .bind(to: viewModel.floorNo)
            .disposed(by: disposeBag)
        
        landmarkTV.rx.text
            .orEmpty
            .bind(to: viewModel.landmark)
            .disposed(by: disposeBag)
    }
    
    override func setupCallbacks() {
        viewModel.governrates.bind {
            self.showGvoernrates($0)
        }.disposed(by: disposeBag)
        
        viewModel.cities.bind {
            self.showCities($0)
        }.disposed(by: disposeBag)
        
        viewModel.areas.bind {
            self.showAreas($0)
        }.disposed(by: disposeBag)
        
        viewModel.addressAdded.bind { _ in
            Alert.show(title: nil, message: "_address_added", cancelTitle: "Ok", otherTitles: []) { _ in
                self.pop()
            }
        }.disposed(by: disposeBag)
        
        viewModel.addressUpdated.bind { _ in
            Alert.show(title: nil, message: "_address_updated", cancelTitle: "Ok", otherTitles: []) { _ in
                self.pop()
            }
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func showGvoernrates(_ governrates: [PickerModel]) {
        ActionSheet.show(title: "_select_gov", cancelTitle: "Cancel", otherTitles: governrates.map { $0.name }, sender: governrantTF) {[weak self] index in
            if index != 0 {
                self?.governrantTF.text = governrates[index - 1].name
                self?.viewModel.selectedGov.accept(governrates[index - 1])
            }
        }
    }
    func showCities(_ cities: [PickerModel]) {
        ActionSheet.show(title: "_select_city", cancelTitle: "Cancel", otherTitles: cities.map { $0.name }, sender: governrantTF) {[weak self] index in
            if index != 0 {
                self?.cityTF.text = cities[index - 1].name
                self?.viewModel.selectedCity.accept(cities[index - 1])
            }
        }
    }
    func showAreas(_ areas: [PickerModel]) {
        ActionSheet.show(title: "_select_gov", cancelTitle: "Cancel", otherTitles: areas.map { $0.name }, sender: governrantTF) {[weak self] index in
            if index != 0 {
                self?.areaTF.text = areas[index - 1].name
                self?.viewModel.selectedArea.accept(areas[index - 1])
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func saveClicked(_ sender: UIButton) {
        viewModel.addNewAddress()
    }
    
}

extension AddAddressViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case governrantTF:
            viewModel.listGovernrates()
        case cityTF:
            viewModel.listCities()
        case areaTF:
            viewModel.listAreas()
        default:
            break
        }
        return false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "_landmark".localized {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "_landmark".localized
        }
    }
    
}
