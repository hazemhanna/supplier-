//
//  CategoriesViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 04/06/2022.
//

import UIKit

final class CategoriesViewController: HomeViewController {

    // MARK: - Outlets
    @IBOutlet weak var categoryOffersLabel: UILabel!
    
    // MARK: - Variables
    let categoryModel: CategoryModel
    
    // MARK: - Life Cycle
    init(categoryModel: CategoryModel) {
        self.categoryModel = categoryModel
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
        super.setupView()
        categoryOffersLabel.text = "offers ".localized + categoryModel.name
    }
    
    // MARK: - Actions

}
