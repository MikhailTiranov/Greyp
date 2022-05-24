//
//  RSSDetailViewController.swift
//  Greyp
//
//  Created by Mihail Tiranov on 22.05.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class RSSDetailViewController: UIViewController {
    
    // MARK: - Private (Properties)
    private var tableView: UITableView!

    private let viewModel: RSSDetailViewModel
    private let disposeBag = DisposeBag()
    
    private let cellIdentifier = "feedsCell"
    
    // MARK: - Init
    init(with viewModel: RSSDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        configureTableView()
        
        setupViews()
        setupLayout()
        bind()
    }
    
    // MARK: - Private (Interface)
    private func setupNavigation() {
        title = viewModel.endPoint.rawValue
    }
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureTableView() {
        tableView = UITableView()
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        tableView.register(FeedCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func bind() {
        tableView
            .rx
            .modelSelected(RSSItem.self)
            .withUnretained(self)
            .bind {
                guard let link = $1.link else { return }
                $0.openLinkInSafariViewController(link: link)
            }
            .disposed(by: disposeBag)
        
        viewModel.feed.asObservable()
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: cellIdentifier, cellType: FeedCell.self
                )
            ) { _, item, cell in
                cell.titleLabel.text = item.title
                if let link = item.imageLink {
                    cell.feedImageView.loadImage(with: link)
                }
            }
            .disposed(by: disposeBag)
    }
}

extension RSSDetailViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat { 70.0 }
}
