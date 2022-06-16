//
//  MyPostsTableViewCell.swift
//  ElsupplierApp
//
//  Created by MAC on 15/06/2022.
//

import UIKit

protocol MyPostsTableViewCellDelegate: AnyObject {
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, didLike item: PostModel)
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, didAddComent item: PostModel,comment : String)
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, sendMessage item: PostModel)
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, makeCall item: PostModel)

}


class MyPostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight : NSLayoutConstraint!
    @IBOutlet weak var userImage : UIImageView!
    @IBOutlet weak var userName : UILabel!
    @IBOutlet weak var bostBody : UILabel!
    @IBOutlet weak var dateLbl  : UILabel!
    @IBOutlet weak var userType : UILabel!
    @IBOutlet weak var addCommentTF  : UITextField!
    
    weak var delegate: MyPostsTableViewCellDelegate?
    
    var posts : PostModel!{
        didSet{
            userImage.setImageWith(stringUrl: posts.postOwnerImage)
            userName.text = posts.postOwner
            bostBody.text = posts.body
            dateLbl.text = posts.postDate
            userType.text = posts.postOwnerRole
            collectionView.reloadData()
            if posts.media.count > 0 {
                collectionViewHeight.constant = 100
            }else {
                collectionViewHeight.constant = 0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.registerCell(ofType: ImageCollectionViewCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.delegate = self
        collectionView.dataSource = self
        selectionStyle = .none
    }
    
    @IBAction func likeClicked(_ sender: UIButton) {
        delegate?.myPostsTableViewCell(self, didLike: posts)
    }
    
    @IBAction func addCommentClicked(_ sender: UIButton) {
        delegate?.myPostsTableViewCell(self, didAddComent: posts,comment : addCommentTF.text ?? "")
    }
    
    @IBAction func sendMessageClicked(_ sender: UIButton) {
        delegate?.myPostsTableViewCell(self, sendMessage: posts)
    }
    
    @IBAction func makeCallClicked(_ sender: UIButton) {
        delegate?.myPostsTableViewCell(self, makeCall: posts)
    }
    
}

extension MyPostsTableViewCell: UICollectionViewDelegate,
                                        UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.media.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        if posts.media.count > 3 {
        if indexPath.row == 2 {
            cell.blackView.isHidden = false
        }else{
            cell.blackView.isHidden = true
        }
     }else{
         cell.blackView.isHidden = true
     }
        cell.imageNumber.text = "\(posts.media.count)"
        cell.itemImage.setImageWith(stringUrl: posts.media[indexPath.row].media)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 3.5) , height: 100)
    }
}
