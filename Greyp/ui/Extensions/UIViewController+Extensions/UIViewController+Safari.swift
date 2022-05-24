//
//  UIViewController+Safari.swift
//  Greyp
//
//  Created by Mihail Tiranov on 23.05.2022.
//

import UIKit
import SafariServices

extension UIViewController {
    func openLinkInSafariViewController(link: String) {
        guard let url = URL(string: link) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}
