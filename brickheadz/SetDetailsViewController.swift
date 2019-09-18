//
//  SetDetailsViewController.swift
//  brickheadz
//
//  Created by Anastasiia Gachkovskaya on 18/09/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import UIKit

final class SetDetailsViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var piecesLabel: UILabel!

    var set: LegoSet!
    var viewModel: SetDetailsViewModel!

    static func instantiate(
        set: LegoSet
    ) -> SetDetailsViewController {
        let controller = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: "SetDetailsViewController"
        ) as! SetDetailsViewController

        controller.title = "Set Details"
        controller.set = set
        controller.viewModel = SetDetailsViewModel(set: set)
        return controller
    }

    override func viewDidLoad() {
        bindViewModel()
        viewModel.viewDidLoad()
    }

    private func bindViewModel() {
        viewModel.delegate = self
    }

    private func prepareViews() {
        imageView.layer.cornerRadius = 20
    }
}

extension SetDetailsViewController: SetDetailsViewModelDelegate {
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }

    func setSerial(_ serial: String) {
        serialLabel.text = serial
    }

    func setName(_ name: String) {
        nameLabel.text = name
    }

    func setYear(_ year: String) {
        yearLabel.text = year
    }

    func setPieces(_ pieces: String) {
        piecesLabel.text = pieces
    }
}
