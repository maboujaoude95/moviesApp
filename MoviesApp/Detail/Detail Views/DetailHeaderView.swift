//
//  DetailHeaderView.swift
//  MoviesApp
//
//  Created by Mark Aboujaoude on 2020-01-22.
//  Copyright © 2020 Mark Aboujaoude. All rights reserved.
//

import Foundation
import UIKit

class DetailHeaderView: UIView {

    init(backDropPath: String?) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))

        let backDropImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 200))
        backDropImageView.downloadImage(with: backDropPath)
        backDropImageView.translatesAutoresizingMaskIntoConstraints = false
        backDropImageView.contentMode = .scaleAspectFill
        self.addSubview(backDropImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
