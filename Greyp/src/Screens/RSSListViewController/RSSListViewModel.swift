//
//  RSSListViewModel.swift
//  Greyp
//
//  Created by Mihail Tiranov on 22.05.2022.
//

import RxRelay

final class RSSListViewModel {
    
    // MARK: - Public (Properties)
    let endPoints = BehaviorRelay(value: FeedsEndPoint.allCases)
}
