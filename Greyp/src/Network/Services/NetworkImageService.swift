//
//  NetworkImageService.swift
//  Greyp
//
//  Created by Mihail Tiranov on 24.05.2022.
//

import Foundation
import RxSwift

final class NetworkImageService {
    
    // MARK: - Public (Interface)
    static func loadData(from url: URL) -> Observable<Data> {
        Observable.create { observer in
            URLSession.shared.rx.response(request: URLRequest(url: url)).debug("r").subscribe(
                onNext: { response in
                    observer.onNext(response.data)
                },
                onError: {error in
                    observer.onError(error)
                })
        }
    }
}
