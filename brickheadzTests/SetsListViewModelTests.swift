//
//  SetsListViewModelTests.swift
//  brickheadzTests
//
//  Created by Anastasiia Gachkovskaya on 19/09/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import XCTest
@testable import brickheadz

class SetsListViewModelTests: XCTestCase {

    private final class MockDelegate: SetsListViewModelDelegate {

        var alertWasShown = false
        func showAlert(error: Error) {
            alertWasShown = true
        }

        var spinnerWasStarted = false
        var andThenStopped = false
        func shouldEnableSpinner(_ enabled: Bool) {
            if enabled {
                spinnerWasStarted = true
            } else {
                andThenStopped = spinnerWasStarted
            }
        }

        var reloadDataWasRequested = false
        func reloadData() {
            reloadDataWasRequested = true
        }
    }

    var viewModel: SetsListViewModel!
    var apiMock: LegoSetsApiMock!

    override func setUp() {
        apiMock = LegoSetsApiMock()
        viewModel = SetsListViewModel(legoSetsApiService: apiMock)
    }

    func testViewDidLoadFetchesSets() {
        apiMock.mockedSetsResult = .failure(NSError())

        viewModel.viewDidLoad()
        XCTAssertTrue(apiMock.fetchSetsWasCalled)
    }

    func testSpinnerWasStartedAndThenStopped() {
        apiMock.mockedSetsResult = .failure(NSError())

        let delegate = MockDelegate()
        viewModel.delegate = delegate
        viewModel.viewDidLoad()

        XCTAssertTrue(delegate.spinnerWasStarted)
        XCTAssertTrue(delegate.andThenStopped)
    }

    func testTableViewReloadedIfSetsWereLoadedSuccessfully() {
        apiMock.mockedSetsResult = .success([.sample()])

        let delegate = MockDelegate()
        viewModel.delegate = delegate
        viewModel.viewDidLoad()

        XCTAssertTrue(delegate.reloadDataWasRequested)
    }

    func testShowsAlertInCaseOfError() {
        apiMock.mockedSetsResult = .failure(NSError())

        let delegate = MockDelegate()
        viewModel.delegate = delegate
        viewModel.viewDidLoad()

        XCTAssertTrue(delegate.alertWasShown)
    }

    func testNumberOfRows() {
        apiMock.mockedSetsResult = .success([
            .sample(),
            .sample(),
            .sample()
        ])

        viewModel.viewDidLoad()

        XCTAssertEqual(viewModel.numberOfRows(), 3)
    }

    func testGivesCorrectModelForRow() {
        apiMock.mockedSetsResult = .success([
            .sample(),
            .sample(name: "correctName"),
            .sample()
        ])

        viewModel.viewDidLoad()

        XCTAssertEqual(viewModel.modelForRow(1).name, "correctName")
    }
}
