//
//  SetsDetailsViewModelTests.swift
//  brickheadzTests
//
//  Created by Anastasiia Gachkovskaya on 18/09/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import XCTest
@testable import brickheadz

class SetsDetailsViewModelTests: XCTestCase {

    private final class MockDelegate: SetDetailsViewModelDelegate {

        var setImageWasCalled = false
        func setImage(_ image: UIImage?) {
            setImageWasCalled = true
        }

        var setSerialWasCalled = false
        func setSerial(_ serial: String) {
            setSerialWasCalled = true
        }

        var setNameWasCalled = false
        func setName(_ name: String) {
            setNameWasCalled = true
        }

        var setYearWasCalled = false
        func setYear(_ year: String) {
            setYearWasCalled = true
        }

        var setPiecesWasCalled = false
        func setPieces(_ pieces: String) {
            setPiecesWasCalled = true
        }
    }

    var viewModel: SetDetailsViewModel!

    func testViewDidLoadUpdatesInterface() {
        let apiMock = LegoSetsApiMock()
        viewModel = SetDetailsViewModel(set: .sample(), legoSetsApiService: apiMock)

        let delegate = MockDelegate()
        viewModel.delegate = delegate
        viewModel.viewDidLoad()

        XCTAssertTrue(delegate.setNameWasCalled)
        XCTAssertTrue(delegate.setYearWasCalled)
        XCTAssertTrue(delegate.setPiecesWasCalled)
        XCTAssertTrue(delegate.setSerialWasCalled)
    }

    func testViewDidLoadFetchesImage() {
        let apiMock = LegoSetsApiMock()
        apiMock.mockedFetchImageResult = UIImage()
        viewModel = SetDetailsViewModel(
            set: .sample(imageUrl: URL(string: "http://google.com")!),
            legoSetsApiService: apiMock
        )

        let delegate = MockDelegate()
        viewModel.delegate = delegate
        viewModel.viewDidLoad()

        XCTAssertTrue(apiMock.fetchImagesWasCalled)
        XCTAssertTrue(delegate.setImageWasCalled)
    }
}
