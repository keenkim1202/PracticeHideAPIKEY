//
//  WeatherViewController.swift
//  PracticeHideAPIKEY
//
//  Created by KEEN on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {

  // MARK: - UI
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var currentTempLabel: UILabel!
  @IBOutlet weak var currentHumiditylabel: UILabel!
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchWeatherInfomation()
  }
  
  // MARK: Fetching Datas
  func fetchWeatherInfomation() {
    let url = "url을 적어주세요"
    
    AF.request(url, method: .get).validate().responseJSON { response in
      switch response.result {
      case .success(let value):
        let json = JSON(value)
        print("JSON: \(json)")
        
      case .failure(let error):
        print(error)
      }
    }
  }
}

