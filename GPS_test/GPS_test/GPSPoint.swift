//
//  GPSPoint.swift
//  GPS_test
//
//  Created by Lee Lounsbury on 1/28/20.
//  Copyright © 2020 Lee Lounsbury. All rights reserved.
//

import Foundation

class GPSPoint {
    var latitude: Double
    var longitude: Double
    
    init(_ lat: Double, _ long: Double) {
        self.latitude = lat
        self.longitude = long
    }

    func update(_ lat: Double, _ long: Double) {
        self.latitude = lat
        self.longitude = long
    }
}
