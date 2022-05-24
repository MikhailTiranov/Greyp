//
//  Reactive+Extensions.swift
//  Greyp
//
//  Created by Mihail Tiranov on 23.05.2022.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: NotificationCenter {
    func applicationWillEnterForeground() -> ControlEvent<Void> {
        let source = NotificationCenter.default.rx.notification(
            UIApplication.willEnterForegroundNotification
        ).map({ _ in })
        
        return ControlEvent(events: source)
    }
}
