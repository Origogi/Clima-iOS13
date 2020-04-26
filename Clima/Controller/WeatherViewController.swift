//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!

    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()


        searchTextField.delegate = self
        weatherManager.delegate = self
    }
    @IBAction func locationPressed(_ sender: Any) {
        locationManager.requestLocation()
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        print(searchTextField.text!)
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Type something"
            return false
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }

        textField.text = ""
    }
}


//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherData: WeatherModel) {

        DispatchQueue.main.async {
            print(weatherData)
            self.temperatureLabel.text = weatherData.temperatureString
            self.conditionImageView.image = UIImage(systemName: weatherData.conditionName)
            self.cityLabel.text = weatherData.cityName

        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}
//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got location data")

        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude

            print(lat)
            print(lon)

            weatherManager.fetchWeather(latitude: lat, longtitude: lon)
        }
    }
}

