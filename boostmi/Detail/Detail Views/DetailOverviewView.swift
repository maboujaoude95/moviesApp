//
//  DetailOverviewView.swift
//  boostmi
//
//  Created by Mark Aboujaoude on 2020-01-22.
//  Copyright © 2020 Mark Aboujaoude. All rights reserved.
//

import Foundation
import UIKit

class DetailOverviewView: UIView {

    var overview: String?

    init(frame: CGRect, overview: String) {
        self.overview = overview
        super.init(frame: frame)
        setUpRatingsView()
    }

    private func setUpRatingsView() {
        let overviewText = UITextView(frame: CGRect(x: 0, y: 0, width: self.bounds.width - 5, height: 500) )
        overviewText.text = self.overview
        overviewText.font = UIFont.boldSystemFont(ofSize:12)
        overviewText.textColor = .white
        overviewText.backgroundColor = .clear
        self.addSubview(overviewText)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
