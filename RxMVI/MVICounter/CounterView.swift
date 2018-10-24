//
//  CounterView.swift
//  RxMVI
//
//  Created by Dinesh IIINC on 23/10/18.
//  Copyright © 2018 kite.work. All rights reserved.
//

import Foundation

protocol CounterView {
  func renderView(for state: CounterState)
  func displayCount(count: Int)
}

extension CounterView {
  func renderView(for state: CounterState) {
    displayCount(count: state.count)
  }
}
