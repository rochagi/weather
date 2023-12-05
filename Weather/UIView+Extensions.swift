//
//  UIView+Extensions.swift
//  Weather
//
//  Created by Giovanna Rocha on 04/12/23.
//

import Foundation
import UIKit

extension UIView {
    func setConstraintsToParents(_ parent: UIView){
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parent.topAnchor),
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
        ])
    }
}
