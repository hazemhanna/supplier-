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
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, selectMedia item: PostModel,index :Int)

}

class MyPostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bostBody: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var addCommentTF: UITextField!
    @IBOutlet weak var likeBtn: UIButton!

    weak var delegate: MyPostsTableViewCellDelegate?
    
    var post: PostModel! {
        didSet {
            userImage.setImageWith(stringUrl: post.postOwnerImage)
            userName.text = post.postOwner
            bostBody.text = post.body
            dateLbl.text = post.postDate
            userType.text = post.postOwnerRole
            collectionView.reloadData()
            if post.media.count > 0 {
                collectionViewHeight.constant = 100
            } else {
                collectionViewHeight.constant = 0
            }
            likeBtn.isSelected = post.isLiked == 1 //.setImage(post.isLiked == 1 ? R.image.liked() : R.image.like(), for: .normal)
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
        delegate?.myPostsTableViewCell(self, didLike: post)
    }
    
    @IBAction func addCommentClicked(_ sender: UIButton) {
        delegate?.myPostsTableViewCell(self, didAddComent: post, comment : addCommentTF.text ?? "")
        addCommentTF.text = ""
        
    }
    
    @IBAction func sendMessageClicked(_ sender: UIButton) {
        delegate?.myPostsTableViewCell(self, sendMessage: post)
    }
    
    @IBAction func makeCallClicked(_ sender: UIButton) {
        delegate?.myPostsTableViewCell(self, makeCall: post)
    }
    
}

extension MyPostsTableViewCell: UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { post.media.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        if post.media.count > 3 {
            if indexPath.row == 2 {
                cell.blackView.isHidden = false
            } else {
                cell.blackView.isHidden = true
            }
        } else {
            cell.blackView.isHidden = true
        }
        cell.imageNumber.text = "\(post.media.count)"
        cell.itemImage.setImageWith(stringUrl: post.media[indexPath.row].media)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width / 3.5) , height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.myPostsTableViewCell(self, selectMedia: post, index: indexPath.row)
    }
}
