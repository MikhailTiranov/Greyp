//
//  AppFlowController.swift
//  Greyp
//
//  Created by Mihail Tiranov on 19.05.2022.
//

import UIKit

final class AppFlowController: UIViewController {

    // MARK: - Private (Properties)
    private let flowNavigationController = UINavigationController(
        navigationBarClass: nil, toolbarClass: nil
    )
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        embed(flowNavigationController)
        showRSSListViewController()
    }
    
    // MARK: - Private (Interface)
    private func showRSSListViewController() {
        let viewModel = RSSListViewModel()
        let viewController = RSSListViewController(with: viewModel)
        viewController.onFeedTapped = { [weak self] in
            self?.showRSSDetailViewController(with: $0)
        }
        flowNavigationController.setViewControllers([viewController], animated: false)
    }
    
    private func showRSSDetailViewController(with endPoint: FeedsEndPoint) {
        let viewModel = RSSDetailViewModel(with: endPoint, networkService: NetworkFeedService())
        let viewController = RSSDetailViewController(with: viewModel)
        flowNavigationController.pushViewController(viewController, animated: true)
    }
}
