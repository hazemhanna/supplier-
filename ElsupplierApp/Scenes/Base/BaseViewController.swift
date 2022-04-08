//
//  BaseViewController.swift
//
//  Created by Ahmed Madeh.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    // MARK: - Outlets
    
    // MARK: - Variables
    let disposeBag = DisposeBag()
    fileprivate let viewModel = BaseViewModel()
    
    // MARK: - LifeCycle
    init() {
       super.init(nibName: nil, bundle: nil)
   }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
            
    deinit {
        print(String(describing: type(of: self)) + "  Deinit")
    }
    
    // MARK: - Functions
    func setupView() {
        bindViewsToViewModel()
        bindViewModelToViews()
        setupCallbacks()
//        setupBackgroundView()
//        if shouldShowDismissButon() {
//            setupBackButton()
//        }
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let color = UIColor.black
        navigationController?.navigationBar.tintColor = color
        let font = R.font.cairoBold(size: 20) ?? UIFont.boldSystemFont(ofSize: 20)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color, .font: font]
        tabBarController?.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color, .font: font]
        tabBarController?.navigationController?.title = title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = !shouldShowNavigation()
    }
    
    func bindViewsToViewModel() { }
    func bindViewModelToViews() {}
    func setupCallbacks() { }
    
    private func setupBackgroundView() {
        if shouldSetupMaskedView() {
            let view = UIView.init()
            view.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
            view.layer.maskedCorners = [.layerMaxXMinYCorner,  .layerMinXMinYCorner]
            view.layer.cornerRadius = 30
            view.layer.masksToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
            self.view.backgroundColor = .clear
            self.view.sendSubviewToBack(view)
//            view.snp.makeConstraints { (maker) in
//                maker.leading.equalToSuperview()
//                maker.trailing.equalToSuperview()
//                maker.bottom.equalToSuperview()
//                maker.top.equalTo(self.view.snp.top).inset(110)
//
//            }

            view.heightAnchor.constraint(equalTo: self.view.heightAnchor,multiplier: 0.87).isActive = true
            view.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant : 0).isActive = true
            view.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant : 0 ).isActive = true
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant : 0).isActive = true
        }

//        if !shouldShowTopView() { return }
//        let imageView = UIImageView(image: R.image.upperPart())
//        self.view.addSubview(imageView)
//        imageView.snp.makeConstraints { maker in
//            maker.top.equalTo(self.view.snp.top)
//            maker.leading.equalTo(self.view.snp.leading)
//            maker.trailing.equalTo(self.view.snp.trailing)
//            maker.height.equalTo(170)
//        }
//        self.view.sendSubviewToBack(imageView)
    }
    
    func shouldShowDismissButon() -> Bool {
        return true
    }
    
    func shouldShowNavigation() -> Bool {
        return true
    }
        
//    private func setupBackButton() {
//        let item = UIBarButtonItem(image: R.image.back(), style: .plain, target: self, action: #selector(customNavBackClicked(_:)))
//        navigationItem.leftBarButtonItem = item
//    }
    
    func shouldShowTopView() -> Bool {
        return true
    }
    
    func shouldSetupMaskedView() -> Bool {
        return true
    }
    
    @objc func backClicked() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc @IBAction func customNavBackClicked(_ sender: UIButton) {
        pop()
    }
    
    func checkLoggedInUser() -> Bool {
//        if UserModel.current == nil {
//            let controller = LoginAlertViewController()
//            controller.login={
//                self.push(controller: LoginViewController())
//            }
//            self.present(controller, animated: true, completion: nil)
//            return false
//        }
        return true
    }
    // MARK: - Actions
}
