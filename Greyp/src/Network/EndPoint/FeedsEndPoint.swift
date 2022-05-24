//
//  FeedsEndPoint.swift
//  Greyp
//
//  Created by Mihail Tiranov on 22.05.2022.
//

import Foundation

enum FeedsEndPoint: String, CaseIterable {
    
    case aktualno, najnovije, news, show, sport, lifestyle, tech, fun
    
    // MARK: - Private (Properties)
    private var scheme: String { "https" }
    private var host: String { "www.24sata.hr" }
    private var commonPath: String { "/feeds/" }
    private var format: String { ".xml" }
    private var path: String { commonPath + rawValue + format}
    
    // MARK: - Public (Properties)
    var url: URL? {
        var urlComponents = URLComponents()

        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path

        return urlComponents.url
    }
}
