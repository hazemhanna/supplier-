//
//  ReusableView.swift
//  Hemma
//
//  Created by Mahmoud Eissa on 4/30/20.
//  Copyright © 2020 Mahmoud Eissa. All rights reserved.
//

import UIKit

class ReusableView: UIView {


    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
   private func commonInit()  {
    let nibName = String(describing: type(of: self))
        let view =  Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(view)
    }

}

