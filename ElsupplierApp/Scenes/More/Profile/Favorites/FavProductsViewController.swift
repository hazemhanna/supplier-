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
    var selectedCount: Int = 1

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
            Hud.showDismiss($0)
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
        
        viewModel.favoriteToggledSucceeded.bind { [weak self] _ in
            self?.viewModel.listFavorites()
        }.disposed(by: disposeBag)
        
        viewModel.itemAdded.bind { [weak self] _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CartPointsUpdated"), object: nil)
            self?.viewModel.listFavorites()
        }.disposed(by: disposeBag)
        
        viewModel.itemRemoved.bind { [weak self] _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CartPointsUpdated"), object: nil)
            self?.viewModel.listFavorites()
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
        product.inCart == nil ? viewModel.addToCart(itemId: product.id, qty: selectedCount) : viewModel.removeFromCart(itemId: product.inCart?.id ?? product.id)
    }
    
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapFav product: ProductModel) {
        viewModel.favToggle(productId: product.id)
    }
  
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapMin product: ProductModel){
        if selectedCount == 1 { return }
        selectedCount -= 1
        cell.priceTotalLabel.text = (selectedCount * product.price).string()
        cell.counterLbl.text = selectedCount.string()
    }
    
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapPlus product: ProductModel){
        selectedCount += 1
        cell.priceTotalLabel.text = (selectedCount * product.price).string()
        cell.counterLbl.text = selectedCount.string()
    }
    
}
