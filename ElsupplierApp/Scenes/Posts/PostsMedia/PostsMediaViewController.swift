//
//  PostsMediaViewController.swift
//  ElsupplierApp
//
//  Created by MAC on 04/07/2022.
//

import UIKit

class PostsMediaViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Variables
    var list: [MediaModel] = []
    var index : Int

    init(list :[MediaModel], index:Int) {
        self.list = list
        self.index = index
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
        tabBarController?.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        collectionView.registerCell(ofType: PostsMediaCollectionViewCell.self)
        self.collectionView.scrollToItem(at:IndexPath(item: index, section: 0), at: .right, animated: false)
    }

    @IBAction func backClicked(_ sender: UIButton) {
        pop()
    }
    
}

extension PostsMediaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PostsMediaCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        cell.mediaImageView.setImageWith(stringUrl: list[indexPath.row].media)
        cell.deleteIC.isHidden = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
