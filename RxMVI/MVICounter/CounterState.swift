//
//  CounterState.swift
//  RxMVI
//
//  Created by Dinesh IIINC on 23/10/18.
//  Copyright © 2018 kite.work. All rights reserved.
//

import Foundation

struct CounterState {
  let count: Int
}

// State Reducer
extension CounterState {

  static func inital(counter: Int) -> CounterState {
    return CounterState(count: counter)
  }

  func restored() -> CounterState {
    return CounterState(count: count)
  }

  func increaseCount(count: Int) -> CounterState {
    return CounterState(count: count)
  }

  func decreaseCount(count: Int) -> CounterState {
    return CounterState(count: count)
  }
}
