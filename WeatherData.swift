//
//  WeatherData.swift
//  Clima
//
//  Created by 김정태 on 2020/04/24.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Codable {
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Weather : Codable {
    let description : String
    let id : Int
}

struct Main : Codable {
    let temp : Double
    
}
