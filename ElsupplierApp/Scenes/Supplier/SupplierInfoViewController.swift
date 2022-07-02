//
//  SupplierInfoViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 18/06/2022.
//

import UIKit

class SupplierInfoViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var mobileNoButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var sendMessageView: UIView!
    @IBOutlet weak var messageTV: UITextView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var callRequestButton: UIButton!
    @IBOutlet weak var priceRequestButton: UIButton!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var aboutSupplierDesc: UILabel!
    
    // MARK: - Variables
    let supplier: SupplierDetailsModel
    let viewModel = SupplierViewModel()
    
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
        mobileNoButton.setTitle(supplier.supplier.phone, for: .normal)
        emailButton.setTitle(supplier.supplier.email, for: .normal)
        websiteButton.setTitle(supplier.supplier.website, for: .normal)
        addressLabel.text = supplier.supplier.address
        aboutSupplierDesc.text = supplier.supplier.desc.html2String
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
            #warning("show that message sent alert here")
        }.disposed(by: disposeBag)
        
        viewModel.priceRequested.bind { _ in
            Alert.show(message: "_message_sent")
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
    }
    
    @IBAction func callRequestClicked(_ sender: UIButton) {
        viewModel.requestCallBack(supplierId: supplier.id)
    }
    
    @IBAction func priceRequestClicked(_ sender: UIButton) {
        #warning("request price for selected products")
    }
    
    @IBAction func openMessageClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sendMessageView.isHidden = !sender.isSelected
        
        callRequestButton.isSelected = false
        priceRequestButton.isSelected = false
        infoButton.isSelected = false
        infoView.isHidden = true
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
        viewModel.sendMessage(supplierId: supplier.id, message: messageTV.text!)
    }
    
    @IBAction func cancelMessageClicked(_ sender: UIButton) {
    }
}
