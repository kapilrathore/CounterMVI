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

class RxMVITests: XCTestCase {

  private var disposeBag: DisposeBag!

  private var incrementClicks: PublishRelay<Void>!
  private var decrementClicks: PublishRelay<Void>!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
