//
//  RSSDetailViewModel.swift
//  Greyp
//
//  Created by Mihail Tiranov on 22.05.2022.
//

import Foundation
import RxSwift
import UIKit

final class RSSDetailViewModel {
    
    // MARK: - Public (Properties)
    let endPoint: FeedsEndPoint
    
    let feed: Observable<[RSSItem]>
    let load = PublishSubject<Void>()

    // MARK: - Private (Properties)
    private let networkService: NetworkFeedServiceInterface
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(with endpoint: FeedsEndPoint, networkService: NetworkFeedServiceInterface) {
        self.endPoint = endpoint
        self.networkService = networkService
        
        let loadFeed: Observable<[RSSItem]> = Observable.create { observer in
            networkService.sendRequest(for: endpoint) { result in
                switch result {
                case let .failure(error):
                    observer.onError(error)
                case let .success(items):
                    observer.onNext(items)
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
        
        let response = load
            .startWith(())
            .flatMapLatest { loadFeed.materialize() }
            .share()
            .observe(on: MainScheduler.instance)
        
        feed = response.dematerialize()
        
        subscribeOnAppChanges()
    }
    
    // MARK: - Private (Interface)
    private func subscribeOnAppChanges() {
        NotificationCenter
            .default
            .rx
            .applicationWillEnterForeground()
            .withUnretained(self)
            .bind { $0.0.load.onNext(()) }
            .disposed(by: disposeBag)
    }
}
