//
//  WeatherViewController.swift
//  PracticeHideAPIKEY
//
//  Created by KEEN on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class WeatherViewController: UIViewController {

  // MARK: - Properties
  var latitude: Double = 37.65469539112308
  var longitude: Double = 127.0605780377212
  
  let locale = Locale(identifier: "Ko-kr")
  
  // MARK: - UI
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var currentTempLabel: UILabel!
  @IBOutlet weak var currentHumiditylabel: UILabel!
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    getCoordinte(CLLocation(latitude: latitude, longitude: longitude))
    fetchWeatherInfomation()
  }
  
  // MARK: Fetching Datas
  func fetchWeatherInfomation() {

    let appid = Bundle.main.apiKey
    let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(appid)"
    
    AF.request(url, method: .get).validate().responseJSON { response in
      switch response.result {
      case .success(let value):
        let json = JSON(value)
        let humidity = json["main"]["humidity"].stringValue
        let temp = json["main"]["temp"].doubleValue - 273.15
        
        self.currentHumiditylabel.text = "\(humidity) %"
        self.currentTempLabel.text = "\(temp) 도"
      case .failure(let error):
        print(error)
      }
    }
  }
  
  // MARK: Get Address from Lattitude & Longitude
  func getCoordinte(_ coordinate: CLLocation) {
    let geoCoder = CLGeocoder()
    
    geoCoder.reverseGeocodeLocation(coordinate, preferredLocale: locale, completionHandler: {(placemarks, error) in
      if let address: [CLPlacemark] = placemarks {
        guard let city: String = address.last?.administrativeArea else { return }
        guard let gu: String = address.last?.locality else { return }
        guard let dong: String = address.last?.subLocality else { return }
        
        self.locationLabel.text = "\(city), \(gu) \(dong)"
      }
    })
  }
}

