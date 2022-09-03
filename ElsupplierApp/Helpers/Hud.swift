//
//  Hud.swift
//
//  Created by Ahmed Madeh.
//

import UIKit
import RxCocoa
import RxSwift

class Hud {
    
    private static var rootView: UIView? {
        return UIApplication.shared.keyWindow?.rootViewController?.view
    }
    
    static var isVisible: Bool {
        return rootView?.subviews.contains(where: {$0 is LoaderView}) ?? false
    }
    
    static func showDismiss(_ shouldShow: Bool, on view: UIView? = nil)  {
        guard shouldShow else {
            guard let view = view ?? rootView,
                  let loaderView = view.subviews.first(where: {$0 is LoaderView})
            else { return }
            loaderView.removeFromSuperview()
            return
        }
        guard let view = view ?? rootView,
              !isVisible
        else { return }
        view.addSubIntrinsicView(LoaderView())
    }
}
