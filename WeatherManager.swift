//
//  WeatherManager.swift
//  Clima
//
//  Created by 1101373 on 2020/04/12.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherData: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {

    let url = "https://api.openweathermap.org/data/2.5/weather?appid=c5eab2943679de45dbe9266c3cc2be61&units=metric"

    var delegate: WeatherManagerDelegate?

    func fetchWeather(cityName: String) {
        let urlString = "\(url)&q=\(cityName)"

        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }

                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        self.delegate?.didUpdateWeather(self, weatherData: weather)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJson(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()

        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)

            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name

            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)

            return weather
        } catch {
            delegate?.didFailWithError(error: error)
        }

        return nil
    }
}
