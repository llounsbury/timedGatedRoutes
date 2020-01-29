//
//  Route.swift
//  GPS_test
//
//  Created by Lee Lounsbury on 1/28/20.
//  Copyright © 2020 Lee Lounsbury. All rights reserved.
//

import Foundation


class Route {
    var track = [(GPSPoint, GPSPoint)]()
    
    static func onSegment(_ p: GPSPoint, _ q: GPSPoint, _ r:GPSPoint) -> Bool {
        if (q.latitude <= max(p.latitude, r.latitude) && q.latitude >= min(p.latitude, r.latitude)
            && q.longitude <= max(p.longitude, r.longitude) && q.longitude >= min(p.longitude, r.longitude)){
            return true
        }
        return false
    }
       
    static func orientation(_ p: GPSPoint, _ q: GPSPoint, _ r:GPSPoint) -> Int {
        let val = (q.longitude - p.longitude) * (r.latitude - q.latitude) - (q.latitude - p.latitude) * (r.longitude - q.longitude)
        if (val == 0){
            return 0
        }
        if (val > 0){
            return 1
        }else{
            return 2
        }
    }
    
    // translated from c++ code on https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/
    func hasPassedThroughGate(_ gateIndex: Int, _ pastLocation: GPSPoint, _ currentLocation: GPSPoint) -> Bool {
        let gatep1 = self.track[gateIndex].0
        let gatep2 = self.track[gateIndex].1
        
        let o1 = Route.orientation(gatep1, gatep2, currentLocation)
        let o2 = Route.orientation(gatep1, gatep2, pastLocation)
        let o3 = Route.orientation(currentLocation, pastLocation, gatep1 )
        let o4 = Route.orientation(currentLocation, pastLocation, gatep2 )
        if (o1 != o2 && o3 != o4){
            return true
        }
        if (o1 == 0 && Route.onSegment(gatep1, currentLocation, gatep2)){
            return true
        }
        if (o2 == 0 && Route.onSegment(gatep1, pastLocation, gatep2)){
            return true
        }
        if (o3 == 0 && Route.onSegment(currentLocation, gatep1, pastLocation)){
            return true
        }
        if (o3 == 0 && Route.onSegment(currentLocation, gatep2, pastLocation)){
            return true
        }
        return false // Doesn't fall in any of the above cases
    }
    
    
   
}
