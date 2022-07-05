//
//  AddPostsViewController.swift
//  ElsupplierApp
//
//  Created by MAC on 15/06/2022.
//

import UIKit

class AddPostsViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var postTf: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    let viewModel = PostsViewModel()
    var attachments: [Data] = []
    var imagesAndThumbnails: [UIImage] = []

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationController?.isNavigationBarHidden = false
        navigationController?.isNavigationBarHidden = false
    }
    
    override func shouldShowNavigation() -> Bool { true }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_addPost".localized
        collectionView.registerCell(ofType: PostsMediaCollectionViewCell.self)
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
        viewModel.succeeded.bind {
            Alert.show(title: $0, message: nil, cancelTitle: "Ok", otherTitles: []) { _ in
                self.pop()
            }
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func addPostClicked(_ sender: UIButton) {
        viewModel.addPost(title: "", body: postTf.text!, images: attachments)
    }
    
    @IBAction func uploadLogoClicked(_ sender: UIButton) {
        ImagePicker.pickImage(sender: sender) { [weak self] image in
            guard let image = image else { return }
            self?.imagesAndThumbnails.append(image)
            self?.attachments.append(image.jpegData(compressionQuality: 0.5)!)
            self?.collectionView.reloadData()
        }
    }
    
    @IBAction func uploadVideoClicked(_ sender: UIButton) {
        ImagePicker.pickVideo(sender: sender) { [weak self] data, image in
            guard let data = data,
                  let image = image
            else { return }
            self?.imagesAndThumbnails.append(image)
            self?.attachments.append(data)
            self?.collectionView.reloadData()
        }
    }    
}

extension AddPostsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { imagesAndThumbnails.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PostsMediaCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        cell.mediaImageView.image = imagesAndThumbnails[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < imagesAndThumbnails.count,
              indexPath.row < attachments.count
        else { return }
        attachments.remove(at: indexPath.row)
        imagesAndThumbnails.remove(at: indexPath.row)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
}
