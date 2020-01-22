//
//  DiscoverCollectionViewController.swift
//  boostmi
//
//  Created by Mark Aboujaoude on 2020-01-21.
//  Copyright © 2020 Mark Aboujaoude. All rights reserved.
//

import UIKit

class DiscoverCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let vm = DiscoverViewModel()

    override func viewDidLoad(){
        super.viewDidLoad();
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cell: DiscoverCell.self)

        NotificationCenter.default.addObserver(self, selector: .refreshTable, name: .didUpdateContent, object: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width/2 - 5
        return CGSize(width: width, height: width * 1.5)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: DiscoverCell.self, at: indexPath)
        cell.backgroundColor = .red
        if let movieItem = vm.movieItem(at: indexPath) {
            cell.setup(movie: movieItem)
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieItem = vm.movieItem(at: indexPath), let id = movieItem.id else {
            collectionView.deselectRow(at: indexPath, animated: true)
            return
        }
        let controller = MovieDeatilsVC(movieId: id)
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc func refreshTable() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

private extension Selector {
    static let refreshTable = #selector(DiscoverCollectionViewController.refreshTable)
}

extension NSNotification.Name {
    static let didUpdateContent = NSNotification.Name("NewContentLoaded")
}
