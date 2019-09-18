//
//  SetDetailsViewModel.swift
//  brickheadz
//
//  Created by Anastasiia Gachkovskaya on 18/09/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import UIKit

protocol SetDetailsViewModelDelegate: class {
    func setImage(_ image: UIImage?)
    func setSerial(_ serial: String)
    func setName(_ name: String)
    func setYear(_ year: String)
    func setPieces(_ pieces: String)
}

final class SetDetailsViewModel {

    weak var delegate: SetDetailsViewModelDelegate?

    // MARK: - Private Properties

    private let set: LegoSet
    private let legoSetsApiService: LegoSetsApiServiceProtocol

    func viewDidLoad() {
        updateInterface()
        fetchImage()
    }

    // MARK: - Init

    init(
        set: LegoSet,
        legoSetsApiService: LegoSetsApiServiceProtocol = LegoSetsApiService()
    ) {
        self.set = set
        self.legoSetsApiService = legoSetsApiService
    }

    private func updateInterface() {
        delegate?.setName(set.name)
        delegate?.setYear(String(set.year))
        delegate?.setPieces(String(set.pieces))
        delegate?.setSerial(set.serialNumber)
    }

    private func fetchImage() {
        guard let url = set.imageUrl else { return }
        legoSetsApiService.fetchImage(url: url) { [weak self] image in
            self?.delegate?.setImage(image)
        }
    }
}
