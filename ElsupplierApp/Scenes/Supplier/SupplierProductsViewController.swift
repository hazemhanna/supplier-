//
//  SupplierProductsViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 11/06/2022.
//

import UIKit

class SupplierProductsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let supplier: SupplierDetailsModel
    var selectedIndex = 0
    var viewModel = CartViewModel()
    let profileViewModel = ProfileViewModel()
    let supplierViewModel = SupplierViewModel()

    var selectedCount: Int = 1
    
    // MARK: - Life Cycle
    init(supplier: SupplierDetailsModel) {
        self.supplier = supplier
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        bindViewModelToViews()
        setupCallbacks()
        tableView.registerCell(ofType: FavProductTableViewCell.self)
        collectionView.registerCell(ofType: SupplierProductCategoryCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.semanticContentAttribute = .forceLeftToRight
        if Language.isArabic {
            collectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        supplier.categoryProducts.first?.isSelected = true
    }
    
    override func bindViewModelToViews() {
        viewModel.isLoading.bind {
            Hud.showDismiss($0)
        }.disposed(by: disposeBag)
        
        profileViewModel.isLoading.bind {
            Hud.showDismiss($0)
        }.disposed(by: disposeBag)
        
         supplierViewModel.isLoading.bind {
            Hud.showDismiss($0)
         }.disposed(by: disposeBag)
        
    }
    
    override func setupCallbacks() {
        viewModel.itemAdded.bind { [weak self] _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CartPointsUpdated"), object: nil)
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.itemRemoved.bind { [weak self] _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CartPointsUpdated"), object: nil)
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        profileViewModel.favoriteToggledSucceeded.bind { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
        
        profileViewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
        
        supplierViewModel.priceRequested.bind { _ in
            Alert.show(message: "_product_price_sent")
        }.disposed(by: disposeBag)
        
        supplierViewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)

    }

    // MARK: - Actions
}

extension SupplierProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        supplier.categoryProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SupplierProductCategoryCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        if Language.isArabic {
            cell.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        let product = supplier.categoryProducts[indexPath.row]
        cell.categoryName.text = product.name
        cell.bgView.backgroundColor = product.isSelected ? R.color.lightBlue() : .white
        cell.bgView.borderWidth = product.isSelected ? 0 : 1
        cell.bgView.borderColor = R.color.lightBlue()!
        cell.categoryName.textColor = product.isSelected ? UIColor.white : R.color.lightBlue()
        cell.bgView.cornerRadius = cell.bgView.frame.height / 2
        cell.bgView.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let textWidth = supplier.categoryProducts[indexPath.row].name.widthOfString (usingFont: .appFont(ofSize: 14, weight: .bold)!) + 40
        return CGSize(width: textWidth, height: collectionView.frame.height - 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        supplier.categoryProducts.forEach { item in
            item.isSelected = false
        }
        supplier.categoryProducts[indexPath.row].isSelected = true
        collectionView.reloadData()
        tableView.reloadData()
    }
}

extension SupplierProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        supplier.categoryProducts.isEmpty ? 0 : supplier.categoryProducts[selectedIndex].products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavProductTableViewCell = tableView.dequeueReusableCell()!
        cell.product = supplier.categoryProducts[selectedIndex].products[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push(controller: ProductDetailsViewController(product: supplier.categoryProducts[selectedIndex].products[indexPath.row]))
    }
}

extension SupplierProductsViewController: FavProductTableViewCellDelegate {
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapAdd product: ProductModel) {
        product.inCart != nil ? viewModel.removeFromCart(itemId: product.inCart?.id ?? product.id) : viewModel.addToCart(itemId: product.id, qty: selectedCount)
        product.inCart = .init()
        cell.addButton.setTitle(product.inCart == nil ? "Add".localized : "_remove".localized, for: .normal)
    }
    
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapFav product: ProductModel) {
        profileViewModel.favToggle(productId: product.id)
        product.isFav = product.isFav == 1 ? 0 : 1
        cell.favButton.isSelected = product.isFav == 1
    }
    
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapMin product: ProductModel) {
        if selectedCount == 1 { return }
        selectedCount -= 1
        cell.priceTotalLabel.text = (selectedCount * product.price).string()
        cell.counterLbl.text = selectedCount.string()
    }
    
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapPlus product: ProductModel) {
        selectedCount += 1
        cell.priceTotalLabel.text = (selectedCount * product.price).string()
        cell.counterLbl.text = selectedCount.string()
    }
    
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapPriceRequest product: ProductModel) {
        supplierViewModel.requestProductPrice(
            supplierId: product.supplier.id,
            productId: product.id,
            quantity: 1
        )
        cell.addButton.isEnabled = false
        cell.addButton.setTitle("_request_price_done".localized, for: .normal)
        cell.addButton.backgroundColor = UIColor(red: 0/255, green: 178/255, blue: 243/255, alpha: 1)
    }
}
