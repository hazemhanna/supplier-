//
//  FavProductsViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/04/2022.
//

import UIKit

class FavProductsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let viewModel = ProfileViewModel()
    var favorites: [ProductModel] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_fav_products".localized
        tableView.registerCell(ofType: FavProductTableViewCell.self)
        viewModel.listFavorites()
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
        viewModel.favorites.bind {
            self.favorites = $0
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
        
        viewModel.favoriteToggledSucceeded.bind { _ in
            self.viewModel.listFavorites()
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
}

extension FavProductsViewController: UITableViewDelegate, TableViewDataSource {
    
    func viewForPlaceholder(in tableView: UITableView) -> UIView {
        Bundle.main.loadNibNamed("EmptyProductsFavView", owner: self, options: [:])?.first as? UIView ?? UIView()
    }
    
    func shouldShowPlaceholder(in tableView: UITableView) -> Bool { favorites.isEmpty }
    
    func frameForPlaceholder(in tableView: UITableView) -> CGRect { tableView.bounds }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { favorites.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavProductTableViewCell = tableView.dequeueReusableCell()!
        cell.product = favorites[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push(controller: ProductDetailsViewController(product: favorites[indexPath.row]))
    }
}

extension FavProductsViewController: FavProductTableViewCellDelegate {
    
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapAdd product: ProductModel) {
    }
    
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapFav product: ProductModel) {
        viewModel.favToggle(productId: product.id)
    }
}
