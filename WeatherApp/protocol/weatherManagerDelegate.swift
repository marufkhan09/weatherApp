//
//  weatherManagerDelegate.swift
//  WeatherApp
//
//  Created by Maruf's Macbook Pro on 19/10/23.
//

import Foundation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weather : WeatherModel)
    func didFailWithError(error: Error)
}
