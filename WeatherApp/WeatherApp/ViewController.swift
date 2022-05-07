//
//  ViewController.swift
//  WeatherApp
//
//  Created by Owen LE BEC on 08/02/2022.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var longitude = Float(0)
    var latitude = Float(0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()

        
        let data:NSData = try! NSData(contentsOf: URL(string:"https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=b8c0162f208b810fd4c2e82e370a98a4")!)
        
        var data_json:[String:Any] = [:]
        do {
        data_json = try JSONSerialization.jsonObject(with: data
        as Data, options: .allowFragments) as! [String:Any]
        } catch let error as NSError {
        print(error)
        }
        
        guard let main = data_json["main"] as? [String:NSNumber] else {
            print("error")
            return
        }
        
        guard let w = data_json["weather"] as? [[String:Any]] else {
            print("error")
            return
        }
        
        let name_dyn = data_json["name"]
        let temp_dyn = (main["temp"] as! NSNumber).stringValue
        let weather_dyn = w[0]["main"]
        
        // Do any additional setup after loading t  he view.
        self.view.backgroundColor =  UIColor.systemGreen
        
        // 1. Initialisation
        let f_param = CGRect(x: 320, y: 32, width: 50, height: 50);
        let param = UIButton(frame: f_param)
        // 2. Paramètrage
        param.frame.origin.x=(self.view.bounds.size.width-param.frame.size.width)
        param.setImage(UIImage(systemName: "gearshape"), for: .normal)
        param.tintColor = UIColor.white
        // 3. Ajout à la vue
        self.view.addSubview(param)
        
        // 1. Initialisation
        let f_city = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 100);
        let city = UILabel(frame: f_city)
        // 2. Paramètrage
        city.font = UIFont(name: "Helvetica", size: 40)
        city.textAlignment = .center
        city.textColor = UIColor.white
        city.text = name_dyn as! String
        // 3. Ajout à la vue
        self.view.addSubview(city)
        
        // 1. Initialisation
        let f_weather = CGRect(x: 0, y: 250, width: 200, height: 200);
        let weather = UIImageView(frame: f_weather)
        // 2. Paramètrage
        weather.frame.origin.x=(self.view.bounds.size.width-weather.frame.size.width)/2.0
        weather.image = UIImage(named: weather_dyn as! String)
        // 3. Ajout à la vue
        self.view.addSubview(weather)
        
        // 1. Initialisation
        let f_temp = CGRect(x: 0, y: 500, width: self.view.frame.width, height: 30)
        let temp = UILabel(frame: f_temp);
        // 2. Paramètrage
        temp.font = UIFont(name: "Helvetica", size: 40)
        temp.textAlignment = .center
        temp.text = temp_dyn + "°C"
        temp.textColor = UIColor.white
        // 3. Ajout à la vue
        self.view.addSubview(temp)
        
        // 1. Initialisation
        let f_time = CGRect(x: 0, y: 550, width: self.view.frame.width, height: 30)
        let time = UILabel(frame: f_time);
        // 2. Paramètrage
        time.font = UIFont(name: "Helvetica", size: 40)
        time.textAlignment = .center
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "hh:mm"
        time.text = dateFormat.string(from: NSDate() as Date)
        time.textColor = UIColor.white
        // 3. Ajout à la vue
        self.view.addSubview(time)
        
        // 1. Initialisation
        let f_refresh = CGRect(x: 0, y: 700, width: 50, height: 50);
        let refresh = UIImageView(frame: f_refresh)
        
        // 2. Paramètrage
        refresh.frame.origin.x=(self.view.bounds.size.width-refresh.frame.size.width)/2.0
        refresh.image = UIImage(named: "Refresh")
        // 3. Ajout à la vue
        self.view.addSubview(refresh)
        
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Found user's location: \(location)")
            var locationArray = locations as NSArray
            var locationObj = locationArray.lastObject as! CLLocation
            var coord = locationObj.coordinate
            longitude  = Float(coord.longitude)
            latitude  = Float(coord.latitude)
            print(longitude)
            print(latitude)
            

        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func loadData(){
        
    }
    
    func test(to : String) 
    
}

