//
//  buttonExtension.swift
//  WeatherApp
//
//  Created by Maruf's Macbook Pro on 21/10/23.
//

import UIKit


extension UIButton {
    func makeCircular() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}
