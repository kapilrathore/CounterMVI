//
//  ViewController.swift
//  RxMVI
//
//  Created by Dinesh IIINC on 23/10/18.
//  Copyright © 2018 kite.work. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

  // Outlets
  @IBOutlet private weak var incrementButton: UIButton!
  @IBOutlet private weak var decrementButton: UIButton!
  @IBOutlet private weak var counterLabel: UILabel!

  // Intentions
  private lazy var incrementIntention = incrementButton.rx.tap.asObservable()
  private lazy var decrementIntention = decrementButton.rx.tap.asObservable()
  private lazy var counterIntentions = CounterIntentions(incrementIntention, decrementIntention)

  // States and Lifecycle Relay
  private lazy var lifecycleRelay = PublishRelay<MviLifecycle>()
  private lazy var statesRelay = BehaviorRelay<CounterState>(value: CounterState.inital(counter: 0))

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    // Bind the model and observe it
    _ = bindModel(states: statesRelay.asObservable(), lifecycle: lifecycleRelay.asObservable())
      .observeOn(MainScheduler.asyncInstance)
      .subscribe { (event) in

        if let state = event.element {
          self.statesRelay.accept(state)
          self.emitted(state: state)
        }
    }

    // to set the initial count == 0
    lifecycleRelay.accept(.created)
  }

  func bindModel(
    states: Observable<CounterState>,
    lifecycle: Observable<MviLifecycle>
  ) -> Observable<CounterState> {
    return CounterModel.bind(lifecycle, states, counterIntentions)
  }

  func emitted(state: CounterState) {
    renderView(for: state)
  }
}

extension ViewController: CounterView {
  func displayCount(count: Int) {
    counterLabel.text = "\(count)"
  }
}
