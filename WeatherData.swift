//
//  WeatherData.swift
//  Clima
//
//  Created by 김정태 on 2020/04/24.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Decodable {
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Weather : Decodable {
    let description : String
}

struct Main : Decodable {
    let temp : Double
    
}
