//
//  RSSResult.swift
//  Greyp
//
//  Created by Mihail Tiranov on 23.05.2022.
//

import Foundation

enum RSSResult {
    case failure(Error)
    case success([RSSItem])
}
