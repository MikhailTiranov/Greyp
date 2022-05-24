//
//  FeedCell.swift
//  Greyp
//
//  Created by Mihail Tiranov on 24.05.2022.
//

import UIKit
import SnapKit

class FeedCell: UITableViewCell {
    
    // MARK: - Public (Properties)
    let feedImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Private (Interface)
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(feedImageView)
        containerView.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        feedImageView.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 60.0, height: 60.0))
            make.leading.equalTo(containerView).inset(10.0)
            make.centerY.equalTo(containerView)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(containerView)
            make.trailing.equalTo(containerView).inset(10.0)
            make.leading.equalTo(feedImageView.snp.trailing).offset(10.0)
        }
    }
}
