//
//  UIViewController+Emded.swift
//  Greyp
//
//  Created by Mihail Tiranov on 22.05.2022.
//

import UIKit
import SnapKit

extension UIViewController {
    func embed(_ child: UIViewController) {
        embed(child, in: view)
    }

    func embed(_ child: UIViewController, in view: UIView) {
        guard let childView = child.view else { return }
        childView.translatesAutoresizingMaskIntoConstraints = false
        child.willMove(toParent: self)
        view.addSubview(childView)
        
        childView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        addChild(child)
    }
}
