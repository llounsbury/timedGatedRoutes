//
//  ViewController.swift
//  GPS_test
//
//  Created by Lee Lounsbury on 1/25/20.
//  Copyright © 2020 Lee Lounsbury. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate{
    
    var pastLocation: GPSPoint = GPSPoint(0,0)
    var location: GPSPoint = GPSPoint(0,0)
    var timeAtStartGate: Double = 0
    var route: Route = Route()
    var lastGatePassed: Int = 0;

    @IBOutlet weak var g1lo1: UILabel!
    @IBOutlet weak var g1la1: UILabel!
    @IBOutlet weak var g1lo2: UILabel!
    @IBOutlet weak var g1la2: UILabel!
    
    @IBOutlet weak var g2lo1: UILabel!
    @IBOutlet weak var g2la1: UILabel!
    @IBOutlet weak var g2lo2: UILabel!
    @IBOutlet weak var g2la2: UILabel!
    
    @IBOutlet weak var lastknownlong: UILabel!
    @IBOutlet weak var lastknownlat: UILabel!
    @IBOutlet weak var lastknowntime: UILabel!
    @IBOutlet weak var lastThroughGate1: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the track to be two points for now
        self.route.track.append((GPSPoint(1,1), GPSPoint(2,2)))
        self.route.track.append((GPSPoint(3,3), GPSPoint(4,4)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
          self.locationManager.requestAlwaysAuthorization()
                 self.locationManager.requestWhenInUseAuthorization()
                           
                 if CLLocationManager.locationServicesEnabled(){
                     locationManager.delegate = self
                     locationManager.desiredAccuracy = kCLLocationAccuracyBest
                     locationManager.startUpdatingLocation()
                 }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard  let trueData: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        self.pastLocation = GPSPoint(self.location.latitude, self.location.longitude)
        self.location = GPSPoint(trueData.latitude, trueData.longitude)
        self.lastknownlat.text = String("\(self.location.latitude)")
        self.lastknownlong.text = String("\(self.location.longitude)")
        self.lastknowntime.text = String("\(NSDate())")
        let time = NSDate().timeIntervalSince1970
        
        if(self.route.hasPassedThroughGate(0, pastLocation, location)){
            self.timeAtStartGate = NSDate().timeIntervalSince1970
            self.lastGatePassed = 1
            self.lastThroughGate1.text = String("\(time - timeAtStartGate)")
        }
        
        if(self.route.hasPassedThroughGate(1, pastLocation, location) && self.lastGatePassed == 1){
            self.lastThroughGate1.text = String("\(NSDate().timeIntervalSince1970 - timeAtStartGate)")
            self.lastGatePassed = 2
        }
    }
    
    @IBAction func restartClicked(_ sender: Any) {
        self.lastGatePassed = 0;
        self.lastThroughGate1.text = "Awaiting Start"
    }
    
    @IBAction func SetG1p1(_ sender: Any) {
        self.route.track[0].0.update(self.location.latitude, self.location.longitude)
        self.g1lo1.text = String("\(self.route.track[0].0.longitude)")
        self.g1la1.text = String("\(self.route.track[0].0.latitude)")
    }
    
    @IBAction func SetG1p2(_ sender: Any) {
        self.route.track[0].1.update(self.location.latitude, self.location.longitude)
        self.g1lo2.text = String("\(self.route.track[0].1.longitude)")
        self.g1la2.text = String("\(self.route.track[0].1.latitude)")
    }
    
    @IBAction func SetG2p1(_ sender: Any) {
        self.route.track[1].0.update(self.location.latitude, self.location.longitude)
        self.g2lo1.text = String("\(self.route.track[1].0.longitude)")
        self.g2la1.text = String("\(self.route.track[1].0.latitude)")
    }
    
    @IBAction func SetG2p2(_ sender: Any) {
        self.route.track[1].1.update(self.location.latitude, self.location.longitude)
        self.g2lo2.text = String("\(self.route.track[1].1.longitude)")
        self.g2la2.text = String("\(self.route.track[1].1.latitude)")
    }
    
}

