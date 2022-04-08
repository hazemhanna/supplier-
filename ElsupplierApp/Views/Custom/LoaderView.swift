//
//  LoaderView.swift
//  El-MOQAWEL
//
//  Created by Ahmed Madeh on 20/09/2021.
//

import UIKit
import SnapKit

class LoaderView: UIView {
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView.init(style: .large)
        view.color = R.color.darkBlue()
        view.startAnimating()
        return view
    }()
    
    private  func setup()  {
        addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setup()
    }
}
