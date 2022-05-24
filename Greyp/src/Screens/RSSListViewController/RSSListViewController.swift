//
//  RSSListViewController.swift
//  Greyp
//
//  Created by Mihail Tiranov on 22.05.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class RSSListViewController: UIViewController {
    
    // MARK: - Public (Properties)
    var onFeedTapped: (FeedsEndPoint) -> () = { _ in }
    
    // MARK: - Private (Properties)
    private var tableView: UITableView!
    
    private let viewModel: RSSListViewModel
    private let disposeBag = DisposeBag()
    
    private let cellIdentifier = "feedsListCell"
        
    // MARK: - Init
    init(with viewModel: RSSListViewModel) {
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
        title = "RSS Sources"
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func bind() {
        tableView
            .rx
            .modelSelected(FeedsEndPoint.self)
            .withUnretained(self)
            .bind { $0.onFeedTapped($1) }
            .disposed(by: disposeBag)
        
        viewModel.endPoints.asObservable()
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: cellIdentifier, cellType: UITableViewCell.self
                )
            ) { _, item, cell in
                cell.textLabel?.text = item.rawValue
            }
            .disposed(by: disposeBag)
    }
}
