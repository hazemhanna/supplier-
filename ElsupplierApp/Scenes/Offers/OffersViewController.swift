//
//  OffersViewController.swift
//  ElsupplierApp
//
//  Created by MAC on 14/06/2022.
//

import UIKit

class OffersViewController: BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var offersCollectionView: UICollectionView!

    // MARK: - Variables
    var viewModel = CartViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        offersCollectionView.registerCell(ofType: OfferCollectionViewCell.self)
        offersCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        offersCollectionView.delegate = self
        offersCollectionView.dataSource = self
        title = "_Ofeers".localized
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

    }
}

extension OffersViewController: UICollectionViewDelegate,
                                        UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OfferCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2.4) , height: 470)
    }
}
