//
//  PostTableViewCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 11/06/2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var supplierImageView: UIImageView!
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var postedDate: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var postContent: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var commentTF: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        collectionView.registerCell(ofType: DetailsImageCollectionCell.self)
    }
    
    @IBAction func likeClicked(_ sender: UIButton) {
    }
    
    @IBAction func requestCallClicked(_ sender: UIButton) {
    }
    
    @IBAction func sendMessageClicked(_ sender: UIButton) {
    }
}

extension PostTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailsImageCollectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
}
