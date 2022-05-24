//
//  NetworkFeedService.swift
//  Greyp
//
//  Created by Mihail Tiranov on 22.05.2022.
//

import FeedKit
import Foundation

protocol NetworkFeedServiceInterface: AnyObject {
    func sendRequest(
        for endPoint: FeedsEndPoint,
        onCompletion: @escaping (RSSResult) -> Void
    )
}

final class NetworkFeedService: NetworkFeedServiceInterface {
    
    // MARK: - NetworkServiceInterface
    func sendRequest(
        for endPoint: FeedsEndPoint,
        onCompletion: @escaping (RSSResult) -> Void
    ) {
        guard let feedURL = endPoint.url else { return }
        
        let parser = FeedParser(URL: feedURL)

        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            switch result {
            case .success(let feed):
                if let rss = feed.rssFeed, let items = rss.items {
                    onCompletion(
                        .success(
                            items.map({
                                RSSItem(
                                    title: $0.title,
                                    link: $0.link,
                                    imageLink: $0.enclosure?.attributes?.url
                                )
                            })
                        )
                    )
                } else {
                    onCompletion(.success([]))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
