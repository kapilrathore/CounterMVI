//
//  RxMVITests.swift
//  RxMVITests
//
//  Created by Dinesh IIINC on 23/10/18.
//  Copyright © 2018 kite.work. All rights reserved.
//

import XCTest
import Foundation
import RxTest
import RxSwift
import RxCocoa
@testable import RxMVI

/*
 Test Cases for CounterModel :
 ============
 1. emits counter when view created
 2. emits counter when view restored
 3. emtis counter when increment clicked
 4. emtis counter when decrement clicked
*/

class RxMVITests: XCTestCase {

  private lazy var initialState = CounterState.inital(counter: 0)

  private var disposeBag: DisposeBag!
//  private var observer: TestableObserver<CounterState>!

  private var lifecycle: PublishRelay<MviLifecycle>!
  private var states: PublishRelay<CounterState>!

  private var incrementClicks: PublishRelay<Void>!
  private var decrementClicks: PublishRelay<Void>!

  private var intentions: CounterIntentions!

  func testEmitsCounter_whenViewCreated() {
    // Setup
    disposeBag = DisposeBag()
    let observer = TestScheduler(initialClock: 0)
      .createObserver(CounterState.self)

    lifecycle = PublishRelay()
    states = PublishRelay()

    incrementClicks = PublishRelay()
    decrementClicks = PublishRelay()

    intentions = CounterIntentions(
      incrementClicks.asObservable(),
      decrementClicks.asObservable()
    )

    // Act
    CounterModel
      .bind(lifecycle.asObservable(), states.asObservable(), intentions)
      .subscribe(observer)
      .disposed(by: disposeBag)

    lifecycle.accept(.created)

    // Assert
    let initial = CounterState(count: 0)
    let expected = [next(0, initial)]
    XCTAssertEqual(observer.events, expected)
  }

  func testEmitsCounter_whenIncrementClickedOnce() {

    // Setup
    disposeBag = DisposeBag()
    let observer = TestScheduler(initialClock: 0)
      .createObserver(CounterState.self)

    lifecycle = PublishRelay()
    states = PublishRelay()

    incrementClicks = PublishRelay()
    decrementClicks = PublishRelay()

    intentions = CounterIntentions(
      incrementClicks.asObservable(),
      decrementClicks.asObservable()
    )

    // Act
    CounterModel
      .bind(lifecycle.asObservable(), states.asObservable(), intentions)
      .do(onNext: { (state) in
        self.states.accept(state)
      }, onError: nil, onCompleted: nil, onSubscribe: nil, onSubscribed: nil, onDispose: nil)
      .subscribe(observer)
      .disposed(by: disposeBag)

    lifecycle.accept(.created)
    incrementClicks.accept(())

    // Assert
    let expected = [next(0, CounterState(count: 0)), next(0, CounterState(count: 1))]
    XCTAssertEqual(observer.events, expected)
  }
}
