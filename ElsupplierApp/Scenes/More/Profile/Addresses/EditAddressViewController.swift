//
//  EditAddressViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 13/05/2022.
//

import UIKit

class EditAddressViewController: AddAddressViewController {

    // MARK: - Outlets
    
    // MARK: - Variables
    let address: AddressModel
    
    // MARK: - Life Cycle
    init(address: AddressModel) {
        self.address = address
        super.init(nibName: "AddAddressViewController", bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_edit_address".localized
        saveButton.setTitle("_save_changes".localized, for: .normal)
        setupViewModel()
        setupTextFields()
    }
    
    func setupViewModel() {
        viewModel.selectedGov.accept(.init(JSON: ["id": address.provinceId, "name_ar": address.govName]))
        viewModel.selectedCity.accept(.init(JSON: ["id": address.cityId, "name_ar": address.cityName]))
        viewModel.selectedArea.accept(.init(JSON: ["id": address.areaId, "name_ar": address.areaName]))
        viewModel.street.accept(address.street)
        viewModel.buildingNo.accept(address.apartment)
        viewModel.floorNo.accept(address.floor)
        viewModel.landmark.accept(address.landmark)
    }
    
    func setupTextFields() {
        governrantTF.text = address.govName
        cityTF.text = address.cityName
        areaTF.text = address.areaName
        streetTF.text = address.street
        buildingNoTF.text = address.apartment
        floorTF.text = address.floor
        landmarkTV.text = address.landmark
    }
    
    // MARK: - Actions
    override func saveClicked(_ sender: UIButton) {
        viewModel.updateAddress(addressId: address.id)
    }

}
