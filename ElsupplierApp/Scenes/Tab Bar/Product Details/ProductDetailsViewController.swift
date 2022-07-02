//
//  ProductDetailsViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 27/05/2022.
//

import UIKit

class ProductDetailsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var piecesNo: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTotalLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var supplierImageView: UIImageView!
    @IBOutlet weak var phoneNoImage: UIImageView!
    @IBOutlet weak var phoneNoButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var relatedCollectionView: UICollectionView!
    @IBOutlet weak var piecesView: UIView!
    @IBOutlet weak var counterLbl : UILabel!
    
    // MARK: - Variables
    let product: ProductModel
    var selectedCount: Int = 1 {
        didSet {
            priceTotalLabel.text = (selectedCount * product.price).string()
            counterLbl.text = selectedCount.string()
        }
    }
    var viewModel = CartViewModel()
    let profileViewModel = ProfileViewModel()
    let supplierViewModel = SupplierViewModel()
    var relatedProducts: [ProductModel] = []
    
    // MARK: - Life Cycle
    init(product: ProductModel) {
        self.product = product
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        viewModel.loadProductDetails(productId: product.id)
        imagesCollectionView.registerCell(ofType: DetailsImageCollectionCell.self)
        relatedCollectionView.registerCell(ofType: RelatedProductCollectionCell.self)
        piecesView.layer.maskedCorners = !Language.isArabic ? [.layerMinXMinYCorner, .layerMaxXMaxYCorner] : [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        piecesView.cornerRadius = 5
        
        imagesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        relatedCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        relatedCollectionView.delegate = self
        relatedCollectionView.dataSource = self
        
        productImageView.setImageWith(stringUrl: product.mainImage)
        piecesNo.text = product.measurmentUnit
        favButton.isSelected = product.isFav == 1
        productName.text = product.name
        priceLabel.text = product.price.string()
        priceTotalLabel.text = product.price.string()
        addToCartButton.setTitle(product.inCart == 1 ? "_remove_from_cart" : "_add_to_cart", for: .normal)
        productDesc.text = product.desc
        supplierName.text = product.supplierName
        supplierImageView.setImageWith(stringUrl: product.supplier.logo)
        phoneNoButton.setTitle(product.supplier.phone, for: .normal)
        emailButton.setTitle(product.supplier.email, for: .normal)
        websiteButton.setTitle(product.supplier.website, for: .normal)
        locationLabel.text = product.supplier.address
        titleLabel.text = product.name
        relatedCollectionView.semanticContentAttribute = .forceLeftToRight
        if Language.isArabic {
            relatedCollectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    
    override func bindViewModelToViews() {
        viewModel.isLoading.bind {
            if $0 {
                Hud.show()
            } else {
                Hud.hide()
            }
        }.disposed(by: disposeBag)
        profileViewModel.isLoading.bind {
            if $0 {
                Hud.show()
            } else {
                Hud.hide()
            }
        }.disposed(by: disposeBag)
    }
    
    override func setupCallbacks() {
        viewModel.itemAdded.bind { [weak self] _ in
            self?.addToCartButton.setTitle("_remove_from_cart", for: .normal)
        }.disposed(by: disposeBag)
        
        viewModel.itemRemoved.bind { [weak self] _ in
            self?.addToCartButton.setTitle("_add_to_cart", for: .normal)
        }.disposed(by: disposeBag)
        
        viewModel.requestCallBackSucceed.bind { _ in
            Alert.show(message: "_request_call_succeed")
        }.disposed(by: disposeBag)
        
        profileViewModel.favoriteToggledSucceeded.bind { [weak self] _ in
            guard let self = self else { return }
            self.product.isFav = self.product.isFav == 1 ? 0 : 1
            self.favButton.isSelected = self.product.isFav == 1
        }.disposed(by: disposeBag)
        
        viewModel.relatedProducts.bind { [weak self] in
            self?.relatedProducts = $0
            self?.relatedCollectionView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func favClicked(_ sender: UIButton) {
        profileViewModel.favToggle(productId: product.id)
    }
    
    @IBAction func plusClicked(_ sender: UIButton) {
        selectedCount += 1
    }
    
    @IBAction func minusClicked(_ sender: UIButton) {
        if selectedCount == 1 { return }
        selectedCount -= 1
    }
    
    @IBAction func addToCartClicked(_ sender: UIButton) {
      viewModel.addToCart(itemId: product.id, qty: selectedCount)
    }
    
    @IBAction func showInfoClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        phoneNoImage.image = sender.isSelected ? R.image.phoneActive() : R.image.phone()
        infoView.isHidden = !sender.isSelected
    }
    
    @IBAction func requestPhoneCallClicked(_ sender: UIButton) {
        viewModel.requestPhoneCall(supplierId: product.supplier.id)
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        pop()
    }
    
    @IBAction func cartClicked(_ sender: UIButton) {
        push(controller: CartViewController(isFromTabbar: false))
    }

    @IBAction func showOnMap(_ sender: UIButton) {
        MapUtil.visit(lat: product.supplier.latitude.doubleValue, long: product.supplier.longitude.doubleValue)
    }
    
    @IBAction func requestPriceClicked(_ sender: UIButton) {
        #warning("check quantity")
        supplierViewModel.requestProductPrice(supplierId: product.supplier.id, productId: product.id, quantity: 1)
    }
    
    @IBAction func phoneClicked(_ sender: UIButton) {
        if let url = URL(string: product.supplier.phone),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func emailClicked(_ sender: UIButton) {
        if let url = URL(string: product.supplier.email),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func websiteClicked(_ sender: UIButton) {
        if let url = URL(string: product.supplier.website),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func facebookClicked(_ sender: UIButton) {
        if let url = URL(string: product.supplier.facebook),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}

extension ProductDetailsViewController: UICollectionViewDelegate,
                                        UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == imagesCollectionView ? product.productImages.count : relatedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imagesCollectionView {
            let cell: DetailsImageCollectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
            cell.imageView.setImageWith(stringUrl: product.productImages[indexPath.row].image)
            return cell
        } else {
            let cell: RelatedProductCollectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
            if Language.isArabic {
                cell.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
            cell.product = relatedProducts[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == relatedCollectionView {
            push(controller: ProductDetailsViewController(product: relatedProducts[indexPath.row]))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == imagesCollectionView ? CGSize(width: 80, height: 80) :
        CGSize(width: 208, height: collectionView.frame.height)
    }
    
}
