//
//  FavoriteSuppliersViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 11/06/2022.
//

import UIKit

class FavoriteSuppliersViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyView: UIView!
    
    // MARK: - Variables
    var list: [SupplierModel] = []
    let viewModel = ProfileViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.listFavoriteSuppliers()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_fav_suppliers".localized
        collectionView.registerCell(ofType: FavoriteSuppliersCollectionCell.self)
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
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
        
        viewModel.favoriteSuppliers.bind { [weak self] in
            self?.list = $0
            self?.collectionView.reloadData()
            self?.emptyView.isHidden = !$0.isEmpty
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions

}

extension FavoriteSuppliersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FavoriteSuppliersCollectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        
        cell.supplierName.text = list[indexPath.row].name
        cell.supplierImageView.setImageWith(stringUrl: list[indexPath.row].logo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
