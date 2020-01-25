//
//  DetailYearView.swift
//  boostmi
//
//  Created by Mark Aboujaoude on 2020-01-22.
//  Copyright © 2020 Mark Aboujaoude. All rights reserved.
//

import Foundation
import UIKit

class DetailYearView: UIView {

    var date: String?

    init(frame: CGRect, date: Date) {
        super.init(frame: frame)
        self.date = formatReleaseDate(date: date)
        setUpDateView()
    }

    private func setUpDateView() {
        let dateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 25) )

        dateLabel.text = self.date
        dateLabel.font = dateLabel.font.withSize(11)
        dateLabel.textColor = .white

        self.addSubview(dateLabel)
    }

    private func formatReleaseDate(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL d, y"
        return dateFormatter.string(from: date)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
