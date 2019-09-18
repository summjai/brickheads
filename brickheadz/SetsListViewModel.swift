//
//  SetsListViewModel.swift
//  brickheadz
//
//  Created by Anastasiia Gachkovskaya on 18/09/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import Foundation

protocol SetsListViewModelDelegate: class {
    func showAlert(error: Error)
    func shouldEnableSpinner(_ enabled: Bool)
    func reloadData()
}

final class SetsListViewModel {

    // MARK: - Public Properties

    weak var delegate: SetsListViewModelDelegate?

    // MARK: - Private Properties

    private var dataSource = [LegoSet]()
    private let legoSetsApiService: LegoSetsApiServiceProtocol

    // MARK: - Init

    init(legoSetsApiService: LegoSetsApiServiceProtocol = LegoSetsApiService()) {
        self.legoSetsApiService = legoSetsApiService
    }

    func viewDidLoad() {
        fetchSets()
    }

    func modelForRow(_ row: Int) -> LegoSet {
        return dataSource[row]
    }

    func numberOfRows() -> Int {
        return dataSource.count
    }

    // MARK: - Private Methods

    private func fetchSets() {
        delegate?.shouldEnableSpinner(true)
        legoSetsApiService.fetchSets { [weak self] result in
            guard let self = self else { return }
            self.delegate?.shouldEnableSpinner(false)
            switch result {
            case .success(let sets):
                self.dataSource = sets
                self.delegate?.reloadData()
            case .failure(let error):
                self.delegate?.showAlert(error: error)
            }
        }
    }
}
