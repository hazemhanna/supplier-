//
//  AddressesViewModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 11/05/2022.
//

import RxCocoa
import RxRelay

class AddressesViewModel: BaseViewModel {
    
    var selectedGov = BehaviorRelay<PickerModel?>(value: nil)
    var selectedCity = BehaviorRelay<PickerModel?>(value: nil)
    var selectedArea = BehaviorRelay<PickerModel?>(value: nil)
    var street = BehaviorRelay<String>(value: "")
    var buildingNo = BehaviorRelay<String>(value: "")
    var floorNo = BehaviorRelay<String>(value: "")
    var landmark = BehaviorRelay<String>(value: "")
    
    var addresses = PublishRelay<[AddressModel]>()
    var addressDeleted = PublishRelay<Bool>()
    var addressAdded = PublishRelay<Bool>()
    var addressUpdated = PublishRelay<Bool>()
    var addressSelected = PublishRelay<Bool>()
    var shippingAddressSelected = PublishRelay<Int>()
    var governrates = PublishRelay<[PickerModel]>()
    var cities = PublishRelay<[PickerModel]>()
    var areas = PublishRelay<[PickerModel]>()
    
    let profileApis = ProfileAPIs()
    let mockupsApis = MockupsAPIs()
    let cartApis = CartAPIs()

    func listAddresses() {
        isLoading.accept(true)
        profileApis.listAddresses().subscribe {[weak self] addresses in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.addresses.accept(addresses)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func deleteAddress(addressId: Int) {
        isLoading.accept(true)
        profileApis.deleteAddress(addressId: addressId).subscribe {[weak self] _ in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.addressDeleted.accept(true)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func listGovernrates() {
        isLoading.accept(true)
        mockupsApis.listGovernrates().subscribe {[weak self] governrates in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.governrates.accept(governrates)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func listCities() {
        isLoading.accept(true)
        mockupsApis.listCities().subscribe {[weak self] cities in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.cities.accept(cities)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func listAreas() {
        isLoading.accept(true)
        mockupsApis.listAreas().subscribe {[weak self] areas in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.areas.accept(areas)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func validate() -> Bool {
        if selectedGov.value == nil {
            error.accept(NSError(error: "_please_select_gov", code: 0))
            return false
        }
        if selectedCity.value == nil {
            error.accept(NSError(error: "_please_select_city", code: 0))
            return false
        }
        if selectedArea.value == nil {
            error.accept(NSError(error: "_please_select_area", code: 0))
            return false
        }
        if street.value.isEmpty {
            error.accept(NSError(error: "_please_enter_street", code: 0))
            return false
        }
        if buildingNo.value.isEmpty {
            error.accept(NSError(error: "_please_enter_building_no", code: 0))
            return false
        }
        if floorNo.value.isEmpty {
            error.accept(NSError(error: "_please_enter_floor_no", code: 0))
            return false
        }
        return true
    }
    
    func addNewAddress() {
        if !validate() { return }
        isLoading.accept(true)
        profileApis.addAddress(areaId: selectedArea.value!.id, street: street.value,
                               floor: floorNo.value, apartment: buildingNo.value,
                               landmark: landmark.value, cityId: selectedCity.value!.id,
                               provinceId: selectedGov.value!.id).subscribe {[weak self] _ in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.addressAdded.accept(true)
            self.addressSelected.accept(true)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func updateAddress(addressId: Int) {
        if !validate() { return }
        isLoading.accept(true)
        profileApis.updateAddress(addressId: addressId, areaId: selectedArea.value!.id,
                                  street: street.value, floor: floorNo.value,
                                  apartment: buildingNo.value, landmark: landmark.value,
                                  cityId: selectedCity.value!.id, provinceId: selectedGov.value!.id).subscribe {[weak self] _ in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.addressAdded.accept(true)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func selectAddress(addressId: Int) {
        isLoading.accept(true)
        profileApis.selectAddress(addressId: addressId).subscribe {[weak self] _ in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.addressSelected.accept(true)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func selectCartAddress(addressId: Int, index: Int) {
        isLoading.accept(true)
        cartApis.selectShippingAddress(addressId: addressId).subscribe { [weak self] _ in
            self?.isLoading.accept(false)
            self?.shippingAddressSelected.accept(index)
        } onError: { [weak self] error in
            self?.isLoading.accept(false)
            self?.error.accept(error)
        }.disposed(by: disposeBag)
    }
}
