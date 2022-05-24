//
//  UIImageView+Extension.swift
//  Greyp
//
//  Created by Mihail Tiranov on 24.05.2022.
//

import UIKit
import RxSwift
import Foundation

final class WebImageView: UIImageView {
    
    // MARK: - Private (Properties)
    private static let imageCache = NSCache<AnyObject, AnyObject>()
    
    private let defaultImage: UIImage? = {
        UIImage(systemName: "circle.slash")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    }()
    
    private let disposeBag = DisposeBag()
        
    // MARK: - Init
    override init(image: UIImage? = nil) {
        super.init(image: image)
        if image == nil {
            self.image = self.defaultImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Public (Interface)
    func loadImage(with urlSting: String) {
        guard let url = URL(string: urlSting) else { return }
        image = nil
        
        if let imageFromCache = Self.imageCache.object(forKey: urlSting as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        
        NetworkImageService.loadData(from: url)
            .withUnretained(self)
            .subscribe(
                onNext: { owner, data in
                    guard let imageToCache = UIImage(data: data) else { return
                        DispatchQueue.main.async {
                            owner.image = owner.defaultImage
                        }
                    }
                    Self.imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)
                    DispatchQueue.main.async {
                        owner.image = imageToCache
                    }
                },
                onError: { [weak self] _ in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        self.image = self.defaultImage
                    }
                }
            )
            .disposed(by: disposeBag)
    }
}
