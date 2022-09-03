//
//  MyPostsTableViewCell.swift
//  ElsupplierApp
//
//  Created by MAC on 15/06/2022.
//

import UIKit
import AVFoundation

protocol MyPostsTableViewCellDelegate: AnyObject {
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, didLike item: PostModel)
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, didAddComent item: PostModel,comment : String)
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, sendMessage item: PostModel)
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, makeCall item: PostModel)
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, selectMedia item: PostModel,index :Int)
    func myPostsTableViewCell(_ cell: MyPostsTableViewCell, playVideo item: String)
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
    @IBOutlet weak var userActionsStackView: UIStackView!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var commentsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var aboveTableViewLine: UIView!
    
    weak var delegate: MyPostsTableViewCellDelegate?
    
    var post: PostModel! {
        didSet {
            userImage.setImageWith(stringUrl: post.postOwnerImage)
            userName.text = post.postOwner
            bostBody.text = post.body
            dateLbl.text = post.postDate
            userType.text = post.postOwnerRole
            likeBtn.isSelected = post.isLiked == 1

            collectionViewHeight.constant = post.media.isEmpty ? 0 : 100
            collectionView.reloadData()
            
            commentsTableViewHeight.constant = CGFloat(post.comments.count * 100)
            commentsTableView.isHidden = post.comments.isEmpty
            aboveTableViewLine.isHidden = post.comments.isEmpty
            commentsTableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentsTableView.registerCell(ofType: CommentTableViewCell.self)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        post.media.count
    }

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
        if post.media[indexPath.row].isVideo {
            if let url = URL(string: post.media[indexPath.row].media) {
                AVAsset(url: url).generateThumbnail { image in
                    DispatchQueue.main.async {
                        cell.itemImage.image = image
                    }
                }
            }
        } else {
            cell.itemImage.setImageWith(stringUrl: post.media[indexPath.row].media)
        }
        cell.playImage.isHidden = !post.media[indexPath.row].isVideo
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width / 3.5) , height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     if post.media[indexPath.row].isVideo{
         delegate?.myPostsTableViewCell(self, playVideo: post.media[indexPath.row].media)
     }else{
        delegate?.myPostsTableViewCell(self, selectMedia: post, index: indexPath.row)
      }
    }
}

extension MyPostsTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { post.comments.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentTableViewCell = tableView.dequeueReusableCell()!
        cell.comment = post.comments[indexPath.row]
        return cell
    }
}

extension AVAsset {

    func generateThumbnail(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            })
        }
    }
}
