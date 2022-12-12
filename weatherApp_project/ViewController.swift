//
//  ViewController.swift
//  weatherApp_project
//
//  Created by 이동윤 on 2022/12/01.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    
    // 받아온 데이터를 저장할 프로퍼티
    var weather : Weather?
    var main : Main?
    var name : String?

    private func setWeatherUI() {
        let url = URL(string: "https://openweathermap.org/img/wn/\(self.weather?.icon ?? "00")@2x.png")
        let data = try? Data(contentsOf: url!)
        if let data = data {
            iconImageView.image = UIImage(data: data)
        }
        print("썅")
        tempLabel.text = "\(main!.temp)"
        maxTempLabel.text = "\(main!.tempMax)"
        minTempLabel.text =  "\(main!.tempMin)"
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // data fetch
        WeatherService().getWeather { result in
            print(result)
            switch result {
            case.success(let welcome):
                DispatchQueue.main.async {
                    self.weather = welcome.weather.first
                    self.main = welcome.main
                    self.name = welcome.name
                    self.setWeatherUI()
                }
            case.failure(_):
                print("실패")
            }
        }

    }
    
    
}

