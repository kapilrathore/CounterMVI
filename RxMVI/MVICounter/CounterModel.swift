//
//  CounterModel.swift
//  RxMVI
//
//  Created by Dinesh IIINC on 23/10/18.
//  Copyright © 2018 kite.work. All rights reserved.
//

import Foundation
import RxSwift

class CounterModel {

  static func bind(
    _ lifecycle: Observable<MviLifecycle>,
    _ states: Observable<CounterState>,
    _ intentions: CounterIntentions
  ) -> Observable<CounterState> {

    let lifecycleCreatedState = lifecycleCreatedUseCase(lifecycle)
    let lifecycleRestoredState = lifecycleRestoredUseCase(lifecycle, states)
    let incrementState = incrementUseCase(intentions.increment(), states)
    let decrementState = decrementUseCase(intentions.decrement(), states)

    return Observable.merge(
      lifecycleCreatedState,
      lifecycleRestoredState,
      incrementState,
      decrementState
    )
  }

  private static func lifecycleCreatedUseCase(
    _ lifecycle: Observable<MviLifecycle>
  ) -> Observable<CounterState> {
    return lifecycle
      .filter { $0 == .created }
      .map { _ -> CounterState in
        let initialCount = 0
        return CounterState.inital(counter: initialCount)
      }
  }

  private static func lifecycleRestoredUseCase(
    _ lifecycle: Observable<MviLifecycle>,
    _ states: Observable<CounterState>
  ) -> Observable<CounterState> {
    return lifecycle
      .filter { $0 == .restored }
      .withLatestFrom(states)
      .map { state in state.restored() }
  }

  private static func incrementUseCase(
    _ incrementClick: Observable<Void>,
    _ states: Observable<CounterState>
  ) -> Observable<CounterState> {
    return incrementClick
      .withLatestFrom(states) { (_ : Void, state: CounterState) -> CounterState in
        let newCount = state.count + 1
        return state.increaseCount(count: newCount)
    }
  }

  private static func decrementUseCase(
    _ decrementClick: Observable<Void>,
    _ states: Observable<CounterState>
    ) -> Observable<CounterState> {
    return decrementClick
      .withLatestFrom(states) { (_ : Void, state: CounterState) -> CounterState in
        let newCount = state.count - 1
        return state.decreaseCount(count: newCount)
    }
  }
}
