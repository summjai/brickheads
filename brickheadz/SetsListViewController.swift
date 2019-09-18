//
//  ViewController.swift
//  brickheadz
//
//  Created by Anastasiia Gachkovskaya on 18/09/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import UIKit

final class SetsListViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Private Properties

    private let viewModel = SetsListViewModel()
    private let identifier = "defaultCell"

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        setupTableView()
        viewModel.viewDidLoad()
    }

    // MARK: - Private Methods

    private func bindViewModel() {
        viewModel.delegate = self
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: identifier
        )
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SetsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier
        ) else { return UITableViewCell() }
        let model = viewModel.modelForRow(indexPath.row)
        cell.textLabel?.text = model.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let set = viewModel.modelForRow(indexPath.row)
        let detailsController = SetDetailsViewController.instantiate(
            set: set
        )
        navigationController?.pushViewController(
            detailsController,
            animated: true
        )
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SetsListViewController: SetsListViewModelDelegate {

    func reloadData() {
        tableView.reloadData()
    }

    func showAlert(error: Error) {
        let alertController = UIAlertController(
            title: "An error occured",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alertController.addAction(
            .init(title: "Ok", style: .cancel, handler: nil)
        )
        present(alertController, animated: true, completion: nil)
    }

    func shouldEnableSpinner(_ enabled: Bool) {
        if enabled {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
