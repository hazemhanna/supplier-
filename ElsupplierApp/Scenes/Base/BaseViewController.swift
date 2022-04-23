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
        setupBackgroundView()
        
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
        if !shouldShowTopView() { return }
        let _view = UIView()
        _view.backgroundColor = R.color.iceBlue()
        view.addSubview(_view)
        _view.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.equalToSuperview()
            maker.height.equalTo(110)
        }
        view.sendSubviewToBack(_view)
    }
    
    func shouldShowDismissButon() -> Bool {
        true
    }
    
    func shouldShowNavigation() -> Bool {
        true
    }
    
    func shouldShowTopView() -> Bool {
        true
    }
    
    func shouldSetupMaskedView() -> Bool {
        true
    }
    
    @objc func backClicked() {
        navigationController?.dismiss(animated: true)
    }
    
    func checkLoggedInUser() -> Bool {
        if UserModel.current == nil {
            let controller = LoginAlertViewController()
            controller.login = {[weak self] in
                self?.push(controller: LoginViewController())
            }
            self.present(controller, animated: true, completion: nil)
            return false
        }
        return true
    }
    // MARK: - Actions
}
