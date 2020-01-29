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
    
    var latitudeOld: Double = 0
    var longitudeOld: Double = 0
    var timeOld: Double = 0
    
    var latitude: Double = 0
    var longitude: Double = 0
    var time: Double = 0
    
    var gate1lat1: Double = 0
    var gate1long1: Double = 0
    var gate1lat2: Double = 0
    var gate1long2: Double = 0
    var lastTimeThroughGate1: Double = 0
    
    var gate2lat1: Double = 0
    var gate2long1: Double = 0
    var gate2lat2: Double = 0
    var gate2long2: Double = 0
    
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
        
        // Do any additional setup after loading the view.
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
        self.timeOld = self.time
        self.time = NSDate().timeIntervalSince1970
        self.latitudeOld = self.latitude
        self.longitudeOld = self.longitude
        self.latitude = trueData.latitude
        self.longitude = trueData.longitude

        self.lastknownlat.text = String("\(self.latitude)")
        self.lastknownlong.text = String("\(self.longitude)")
        self.lastknowntime.text = String("\(NSDate())")
        
        if(doIntersect()){
            self.lastTimeThroughGate1 = self.time
        }
        
        if(doIntersectG2()){
            self.lastThroughGate1.text = String("\(time - lastTimeThroughGate1)")
        }
       }
    
    
    @IBAction func SetG1p1(_ sender: Any) {
        self.gate1lat1 = self.latitude
        self.gate1long1 = self.longitude
        self.g1lo1.text = String("\(self.gate1long1)")
        self.g1la1.text = String("\(self.gate1lat1)")
    }
    
    @IBAction func SetG1p2(_ sender: Any) {
        self.gate1lat2 = self.latitude
        self.gate1long2 = self.longitude
        self.g1lo2.text = String("\(self.gate1long2)")
        self.g1la2.text = String("\(self.gate1lat2)")
    }
    
    @IBAction func SetG2p1(_ sender: Any) {
        self.gate2lat1 = self.latitude
        self.gate2long1 = self.longitude
        self.g2lo1.text = String("\(self.gate2long1)")
        self.g2la1.text = String("\(self.gate2lat1)")
    }
    
    @IBAction func SetG2p2(_ sender: Any) {
        self.gate2lat2 = self.latitude
        self.gate2long2 = self.longitude
        self.g2lo2.text = String("\(self.gate2long2)")
        self.g2la2.text = String("\(self.gate2lat2)")
    }
    
    
    func onSegment(_ px: Double, _ py: Double, _ qx: Double,_ qy: Double, _ rx: Double, _ ry: Double) -> Bool {
        if (qx <= max(px, rx) && qx >= min(px, rx) && qy <= max(py, ry) && qy >= min(py, ry)){
           return true
        }
        return false
    }
      
    // To find orientation of ordered triplet (p, q, r).
    // The function returns following values
    // 0 --> p, q and r are colinear
    // 1 --> Clockwise
    // 2 --> Counterclockwise
    func orientation(_ px: Double, _ py: Double, _ qx: Double,_ qy: Double, _ rx: Double, _ ry: Double) -> Int
    {
        // See https://www.geeksforgeeks.org/orientation-3-ordered-points/
        // for details of below formula.
        let val = (qy - py) * (rx - qx) - (qx - px) * (ry - qy)
      
        if (val == 0){ return 0}  // colinear
      
        if (val > 0){
            return 1
        }else{
            return 2
        } // clock or counterclock wise
    }
      
    // The main function that returns true if line segment 'p1q1'
    // and 'p2q2' intersect.
    // translated from c++ code on https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/
    func doIntersect() -> Bool
    {
        // Find the four orientations needed for general and
        // special cases
        let o1 = orientation(gate1lat1, gate1long1, gate1lat2, gate1long2, latitude, longitude)
        let o2 = orientation(gate1lat1, gate1long1, gate1lat2, gate1long2, latitudeOld, longitudeOld)
        let o3 = orientation(latitude, longitude, latitudeOld, longitudeOld, gate1lat1, gate1long1 )
        let o4 = orientation(latitude, longitude, latitudeOld, longitudeOld, gate1lat2, gate1long2 )

        // General case
        if (o1 != o2 && o3 != o4){
            return true
        }
      
        // Special Cases
        // p1, q1 and p2 are colinear and p2 lies on segment p1q1
        if (o1 == 0 && onSegment(gate1lat1, gate1long1, latitude, longitude,  gate1lat2, gate1long2)){
            return true
        }
        // p1, q1 and q2 are colinear and q2 lies on segment p1q1
        if (o2 == 0 && onSegment(gate1lat1, gate1long1, latitudeOld, longitudeOld,  gate1lat2, gate1long2)){
            return true
        }
      
       if (o3 == 0 && onSegment(latitude, longitude, gate1lat1, gate1long1,  latitudeOld, longitudeOld)){
            return true
        }
      
         // p2, q2 and q1 are colinear and q1 lies on segment p2q2
         if (o3 == 0 && onSegment(latitude, longitude, gate1lat2, gate1long2,  latitudeOld, longitudeOld)){
                   return true
        }
        return false // Doesn't fall in any of the above cases
    }
    
    func doIntersectG2() -> Bool
    {
        // Find the four orientations needed for general and
        // special cases
        let o1 = orientation(gate2lat1, gate2long1, gate2lat2, gate2long2, latitude, longitude)
        let o2 = orientation(gate2lat1, gate2long1, gate2lat2, gate2long2, latitudeOld, longitudeOld)
        let o3 = orientation(latitude, longitude, latitudeOld, longitudeOld, gate2lat1, gate2long1 )
        let o4 = orientation(latitude, longitude, latitudeOld, longitudeOld, gate2lat2, gate2long2 )

        // General case
        if (o1 != o2 && o3 != o4){
            return true
        }
      
        // Special Cases
        // p1, q1 and p2 are colinear and p2 lies on segment p1q1
        if (o1 == 0 && onSegment(gate2lat1, gate2long1, latitude, longitude,  gate2lat2, gate2long2)){
            return true
        }
        // p1, q1 and q2 are colinear and q2 lies on segment p1q1
        if (o2 == 0 && onSegment(gate2lat1, gate2long1, latitudeOld, longitudeOld,  gate2lat2, gate2long2)){
            return true
        }
      
       if (o3 == 0 && onSegment(latitude, longitude, gate2lat1, gate2long1,  latitudeOld, longitudeOld)){
            return true
        }
      
         // p2, q2 and q1 are colinear and q1 lies on segment p2q2
         if (o3 == 0 && onSegment(latitude, longitude, gate2lat2, gate2long2,  latitudeOld, longitudeOld)){
                   return true
        }
        return false // Doesn't fall in any of the above cases
    }
    
    
}

