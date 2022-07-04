//
//  SupplierInfoViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 18/06/2022.
//

import UIKit

class PriceRequest {
    var productName  = " "
    var productId = 0
    var quantity = 0
    var completed: Bool {
        return productId != 0 && quantity != 0
    }
}

class SupplierInfoViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var mobileNoButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var sendMessageView: UIView!
    @IBOutlet weak var priceRequestView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight : NSLayoutConstraint!
    @IBOutlet weak var messageTV: UITextView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var callRequestButton: UIButton!
    @IBOutlet weak var priceRequestButton: UIButton!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var aboutSupplierDesc: UILabel!
    
    // MARK: - Variables
    let supplier: SupplierDetailsModel
    let viewModel = SupplierViewModel()
    var products = [ProductModel]()
    var productId = 0
    var selectedProducts = [PriceRequest](){
        didSet{
            tableView.reloadData()
            tableViewHeight.constant = CGFloat(200 * selectedProducts.count)
        }
    }
    
    var tempPrice: PriceRequest?
    var index = -1
    
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
        selectedProducts.append(PriceRequest())

        tableView.registerCell(ofType: PriceRequestTableViewCell.self)
        mobileNoButton.setTitle(supplier.supplier.phone, for: .normal)
        emailButton.setTitle(supplier.supplier.email, for: .normal)
        websiteButton.setTitle(supplier.supplier.website, for: .normal)
        addressLabel.text = supplier.supplier.address
        aboutSupplierDesc.text = supplier.supplier.desc.html2String
        supplier.categoryProducts.forEach { item in
            item.products.forEach { product in
                self.products.append(product)
            }
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
    }
    
    override func setupCallbacks() {
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
        
        viewModel.callbackRequested.bind { _ in
            Alert.show(message: "_request_call_succeed")
        }.disposed(by: disposeBag)
        
        viewModel.messageSent.bind { _ in
            Alert.show(message: "_message_sent")
            self.messageTV.text = ""

        }.disposed(by: disposeBag)
        
        viewModel.priceRequested.bind { _ in
            Alert.show(message: "_product_price_sent")
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func infoClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        infoView.isHidden = !sender.isSelected
        callRequestButton.isSelected = false
        priceRequestButton.isSelected = false
        sendMessageButton.isSelected = false
        sendMessageView.isHidden = true
        priceRequestView.isHidden = true

    }
    
    @IBAction func callRequestClicked(_ sender: UIButton) {
        viewModel.requestCallBack(supplierId: supplier.id)
    }
    
    @IBAction func priceRequestClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        priceRequestView.isHidden = !sender.isSelected
        callRequestButton.isSelected = false
        sendMessageButton.isSelected = false
        infoButton.isSelected = false
        sendMessageView.isHidden = true
        infoView.isHidden = true
    }
    
    @IBAction func openMessageClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sendMessageView.isHidden = !sender.isSelected
        callRequestButton.isSelected = false
        priceRequestButton.isSelected = false
        infoButton.isSelected = false
        infoView.isHidden = true
        priceRequestView.isHidden = true
    }
    
    @IBAction func mobileNoClicked(_ sender: UIButton) {
        if let url = URL(string: supplier.supplier.phone),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func emailClicked(_ sender: UIButton) {
        if let url = URL(string: supplier.supplier.email),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func websiteClicked(_ sender: UIButton) {
        if let url = URL(string: supplier.supplier.website),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func facebookClicked(_ sender: UIButton) {
        if let url = URL(string: supplier.supplier.facebook),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func sendMessageClicked(_ sender: UIButton) {
        if messageTV.text.isEmpty {
            Alert.show(message: "_enter_message")
            return
        }
        viewModel.sendMessage(supplierId: supplier.supplier.id, message: messageTV.text!)
    }
    
    @IBAction func cancelMessageClicked(_ sender: UIButton) {
        messageTV.text = ""
    }
    
    @IBAction func PriceRequestClicked(_ sender: UIButton) {
        if selectedProducts.filter({ $0.completed }).isEmpty {
            Alert.show(message: "_select_product")
            return
        }
        let priceRequestModels: [PriceRequestModel] = selectedProducts.map { .init($0) }
        viewModel.requestSupplierPrice(supplierId: supplier.supplier.id, products: priceRequestModels)
    }
    
    @IBAction func addAnotherClicked(_ sender: UIButton) {
        if let tempPrice = tempPrice, tempPrice.completed, index != -1 {
            selectedProducts[index] = tempPrice
            self.tempPrice = nil
            let add = PriceRequest()
            selectedProducts.append(add)
            tableView.reloadData()
        }
    }
}

extension SupplierInfoViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PriceRequestTableViewCell = tableView.dequeueReusableCell()!
        cell.delegate = self
        cell.price = selectedProducts[indexPath.row]
        cell.index = indexPath.row
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

extension SupplierInfoViewController: PriceRequestTableViewCellDelegate{
    
    func priceRequestTableViewCell(_ cell: PriceRequestTableViewCell) {
        if self.products.count > 0  {
        ActionSheet.show(title: "_choose_product", cancelTitle: "Cancel", otherTitles: products.map { $0.name }, sender: view) { [weak self] index in
            guard let self = self, index != 0 else { return }
            cell.selectedProductLabel.text = self.products[index - 1].name
            self.productId = self.products[index - 1].id
            cell.price.productName = self.products[index - 1].name
            cell.price.productId = self.products[index - 1].id
          }
        }
    }

    func priceRequestTableViewCell(_ cell: PriceRequestTableViewCell, didChangeModel at: Int, price: PriceRequest){
        tempPrice = price
        self.index = at
    }
}
