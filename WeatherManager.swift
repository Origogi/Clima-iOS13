//
//  WeatherManager.swift
//  Clima
//
//  Created by 1101373 on 2020/04/12.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    func fetchWeather(cityName : String) {
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=c5eab2943679de45dbe9266c3cc2be61"

        print(url)
    }
}
