//
//  FavoritesViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/04/2022.
//

import UIKit

class FavoritesViewController: BaseTabBarViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Variables
    var list: [SupplierModel] = []
    let viewModel = ProfileViewModel()
    let viewModel2 = HomeViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationController?.isNavigationBarHidden = false
        viewModel.listFavoriteSuppliers()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "Favorites".localized
        collectionView.registerCell(ofType: FavoriteSuppliersCollectionCell.self)
    }
    
    override func tabBarItemTitle() -> String? {
        "Favorites".localized
    }
    
    override func tabBarItemImage() -> UIImage? {
        R.image.fav()
    }
    
    override func tabBarItemSelectedImage() -> UIImage? {
        R.image.favActive()
    }
    
    override func shouldShowTabBar() -> Bool {
        true
    }
    
    override func bindViewModelToViews() {
        viewModel.isLoading.bind {
            if $0 {
                Hud.show()
            } else {
                Hud.hide()
            }
        }.disposed(by: disposeBag)
        
        viewModel2.isLoading.bind {
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
        
        viewModel2.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
        
        viewModel.favoriteSuppliers.bind { [weak self] in
            self?.list = $0
            self?.collectionView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel2.supplierDetails.bind { [weak self] in
            self?.push(controller: SupplierDetailsViewController(supplier: $0))
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions

}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        viewModel2.getSupplierDetails(with: list[indexPath.row].id)
    }
    
}
