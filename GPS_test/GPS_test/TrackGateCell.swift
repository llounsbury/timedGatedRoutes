//
//  TrackGateCell.swift
//  GPS_test
//
//  Created by Lee Lounsbury on 1/31/20.
//  Copyright © 2020 Lee Lounsbury. All rights reserved.
//

import UIKit

class TrackGateCell: UITableViewCell {

    @IBOutlet weak var GateText: UILabel!
    
    @IBOutlet weak var Coords1: UILabel!
    
    @IBOutlet weak var Coords2: UILabel!
    
    func setGate(gate: (GPSPoint, GPSPoint), index: Int){
        Coords1.text = String("\(gate.0.latitude),\(gate.0.longitude)")
        Coords2.text = String("\(gate.1.latitude),\(gate.1.longitude)")
        GateText.text =  String("GATE \(index + 1)")
    }
    
}
