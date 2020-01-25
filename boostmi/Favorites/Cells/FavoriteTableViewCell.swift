//
//  FavoriteTableViewCell.swift
//  boostmi
//
//  Created by Mark Aboujaoude on 2020-01-24.
//  Copyright © 2020 Mark Aboujaoude. All rights reserved.
//

import Foundation
import UIKit

class FavoriteTableViewCell: UITableViewCell, ReusableCell {

    static var reuseIdentifier: String {
        return String(describing: FavoriteTableViewCell.self)
    }

    let movieImageView = UIImageView()
    let titleLabel = UILabel()
    let favoriteButton = UIButton()
    var currentMovie: Movie?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.movieImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieImageView)

        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.textColor = .white
        contentView.addSubview(titleLabel)

        self.favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.favoriteButton.addTarget(self, action: #selector(removeFavorite), for: .touchUpInside)
        contentView.addSubview(favoriteButton)

        addConstraints()
    }

    private func addConstraints() {
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            self.movieImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.movieImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.movieImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.movieImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.movieImageView.trailingAnchor, constant: padding),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.movieImageView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding),
            self.favoriteButton.centerYAnchor.constraint(equalTo: self.movieImageView.centerYAnchor)
        ])
    }

    func setup(movie: Movie) {
        self.titleLabel.text = movie.title
        self.movieImageView.downloadImage(with: movie.posterPath)
        self.backgroundColor = .black
        self.selectionStyle = .none
        self.currentMovie = movie
        self.favoriteButton.setImage(UIImage(named: "isFavorite.png"), for: .normal)
    }

    @objc func removeFavorite() {
        self.currentMovie?.editFavorite()
        NotificationCenter.default.post(name: .didDeleteFavorite, object: self)
        NotificationCenter.default.post(name: .didUpdateContent, object: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
