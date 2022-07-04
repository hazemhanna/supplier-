//
//  SendMessageViewController.swift
//  ElsupplierApp
//
//  Created by MAC on 04/07/2022.
//



import UIKit

class SendMessageViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var messageTf: UITextField!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Variables
    let viewModel = PostsViewModel()
    let supplierId : Int

    init(supplierId :Int) {
        self.supplierId = supplierId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
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
        titleLabel.text = "_send_supplier_message".localized
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
        viewModel.messageSent.bind { _ in
            Alert.show(title: "_message_sent".localized, message: nil, cancelTitle: "Ok", otherTitles: []) { _ in
                self.pop()
            }
        }.disposed(by: disposeBag)
        
        viewModel.error.bind { error in
            Alert.show(message: error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func addPostClicked(_ sender: UIButton) {
        if messageTf.isEmpty {
            Alert.show(message: "_enter_message")
            return
        }
        viewModel.sendMessage(supplierId: supplierId, message: messageTf.text ?? "")
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        pop()
    }
    
}
