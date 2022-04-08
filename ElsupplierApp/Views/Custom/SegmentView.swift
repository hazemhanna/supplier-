//
//  SegmentView.swift
//
//  Created by Ahmed Madeh.
//

import UIKit
import SnapKit

@IBDesignable
class SegmentView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame: bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(snp.leading)
            maker.trailing.equalTo(snp.trailing)
            maker.top.equalTo(snp.top)
            maker.bottom.equalTo(snp.bottom)
        }
        return collectionView
    }()
    private lazy var view: UIView = {
        let view = UIView()
        addSubview(view)
        sendSubviewToBack(view)
        view.snp.makeConstraints { (maker) in
            maker.leading.equalTo(snp.leading).inset(3)
            maker.top.equalTo(snp.top).inset(3)
            maker.bottom.equalTo(snp.bottom).inset(3)
            maker.width.equalTo(snp.width).multipliedBy(CGFloat(1)/CGFloat(items.count)).inset(3)
        }
        return view
    }()
    @IBInspectable private var itemString: String = "" {
        didSet {
            collectionView.reloadData()
        }
    }
    @IBInspectable private var selectedTextColor: UIColor = .black
    @IBInspectable private var textColor: UIColor = .gray
    @IBInspectable private var selectedViewColor: UIColor = .white {
        didSet{
            view.backgroundColor = selectedViewColor
        }
    }
    var selectedIndex = 0
    weak var delegate: SegmentViewDelegate?

    private var items: [String] {
        return itemString.components(separatedBy: "|")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        view.cornerRadius = view.frame.height / 2
        cornerRadius = frame.height / 2
    }
    private func setupViews()  {
        collectionView.registerCell(ofType: SegmentViewCell.self)
//        backgroundColor = UIColor(hexString: "f0ecee")
//        borderWidth = 1
//        view.borderWidth = 1
//        borderColor = UIColor.init(hexString: "D6D6D6")
//        view.borderColor = UIColor.init(hexString: "D6D6D6")
    }
    func selectedIndex(_ index: Int) {
        let newIndex = index > items.count ? items.count : index
        collectionView(collectionView, didSelectItemAt: IndexPath(row: newIndex, section: 0))
    }
    func updateConsraints() {
        let inset = (bounds.width / CGFloat(items.count)) * CGFloat(selectedIndex) + 3
        view.snp.updateConstraints { (maker) in
            maker.leading.equalTo(snp.leading).inset(inset)
        }
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
}
extension SegmentView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SegmentViewCell", for: indexPath) as! SegmentViewCell
       // cell.label.font = R.font.poppinsMedium(size: 14)
        cell.label.text = items[indexPath.row]
        cell.label.textColor = selectedIndex == indexPath.row ? selectedTextColor : textColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
        delegate?.segmentView(self, didSelect: indexPath.row)
        updateConsraints()
    }
}
extension SegmentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width / CGFloat(items.count), height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
protocol SegmentViewDelegate: AnyObject {
    func segmentView(_ view: SegmentView, didSelect index: Int)
}
