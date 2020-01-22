//
//  DiscoverCell.swift
//  boostmi
//
//  Created by Mark Aboujaoude on 2020-01-21.
//  Copyright © 2020 Mark Aboujaoude. All rights reserved.
//
import Foundation
import UIKit

class DiscoverCell: UICollectionViewCell, ReusableCell {

    static var reuseIdentifier: String {
        return String(describing: DiscoverCell.self)
    }

    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let movieImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.movieImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieImageView)

        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textColor = .white
        contentView.addSubview(self.titleLabel)

        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.textColor = .white
        contentView.addSubview(self.dateLabel)
        addConstraints()
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
        ])
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.dateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5)
        ])
        NSLayoutConstraint.activate([
            self.movieImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.movieImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.movieImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.movieImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        ])
    }

    private func extractYear(date: Date) -> String? {
        return "\(Calendar.current.component(.year, from: date))"
    }

    func setup(movie: Movie) {
        self.titleLabel.text = movie.title
        self.dateLabel.text = extractYear(date: movie.releaseDate)
        let basePosterURL = URL(string: "https://image.tmdb.org/t/p")!
        let posterPath = basePosterURL
            .appendingPathComponent("w300")
            .appendingPathComponent(movie.posterPath ?? "")
//        let data = try? Data(contentsOf: posterPath)
//        if let imageData = data {
//            let image = UIImage(data: imageData)
//            self.movieImageView.image = image
//        }
        self.movieImageView.downloadImage(from: posterPath)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}
