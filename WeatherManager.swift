//
//  WeatherManager.swift
//  Clima
//
//  Created by 1101373 on 2020/04/12.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {

    let url = "https://api.openweathermap.org/data/2.5/weather?appid=c5eab2943679de45dbe9266c3cc2be61&units=metric"

    func fetchWeather(cityName: String) {
        let urlString = "\(url)&q=\(cityName)"

        performRequest(urlString: urlString)
    }

    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }

                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    self.parseJson(weatherData: safeData)
                }
            }
            task.resume()
        }
    }

    func parseJson(weatherData: Data) {
        let decoder = JSONDecoder()

        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodeData.name)
            print(decodeData.main.temp)
            print(decodeData.weather[0].description)


        } catch {
            print(error)
        }

    }

}
