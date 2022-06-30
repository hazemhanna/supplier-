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
        
    }
    
    @IBAction func priceRequestClicked(_ sender: UIButton) {
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
    }
    
    @IBAction func emailClicked(_ sender: UIButton) {
    }
    
    @IBAction func websiteClicked(_ sender: UIButton) {
    }
    
    @IBAction func facebookClicked(_ sender: UIButton) {
    }
    
    @IBAction func sendMessageClicked(_ sender: UIButton) {
    }
    
    @IBAction func cancelMessageClicked(_ sender: UIButton) {
    }
}
