//
//  CounterIntentions.swift
//  RxMVI
//
//  Created by Dinesh IIINC on 23/10/18.
//  Copyright © 2018 kite.work. All rights reserved.
//

import Foundation
import RxSwift

class CounterIntentions {

  private let incrementClicks: Observable<Void>
  private let decrementClicks: Observable<Void>

  init(
    _ incrementClicks: Observable<Void>,
    _ decrementClicks: Observable<Void>
  ) {
    self.incrementClicks = incrementClicks
    self.decrementClicks = decrementClicks
  }

  func increment() -> Observable<Void> {
    return incrementClicks
  }

  func decrement() -> Observable<Void> {
    return decrementClicks
  }
}
