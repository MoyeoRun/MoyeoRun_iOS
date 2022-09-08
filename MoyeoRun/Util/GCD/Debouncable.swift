//
//  Debouncable.swift
//  MoyeoRun
//
//  Created by Jeongho Moon on 2022/09/06.
//

import Foundation

protocol Debouncable: AnyObject {
    var workItem: DispatchWorkItem { get set }
}

extension Debouncable {
    func debounce(
        for interval: TimeInterval,
        scheduler: DispatchQueue = DispatchQueue.main,
        _ action: @escaping () -> Void
    ) {
        workItem.cancel()
        workItem = DispatchWorkItem { action() }
        scheduler.asyncAfter(deadline: .now() + interval, execute: workItem)
    }
}
