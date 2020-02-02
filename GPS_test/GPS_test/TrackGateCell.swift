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
    
    var index: Int = 0;
    
    
    @IBOutlet weak var Coords1: UIButton!
    
    @IBOutlet weak var Coords2: UIButton!
    
    func setGate(gate: (GPSPoint, GPSPoint), index: Int){
    //(String(format: "(%.2f,%.2f)",gate.0.latitude, gate.0.longitude))
        Coords1.setTitle(String(format: "(%.2f,%.2f)",gate.0.latitude, gate.0.longitude), for: .normal)
        Coords2.setTitle(String(format: "(%.2f,%.2f)",gate.1.latitude, gate.1.longitude), for: .normal)
        GateText.text =  String("GATE \(index + 1)")
        self.index = index
    }
    
    @IBAction func SetGateCoords1(_ sender: Any) {
        SelectedTrack.track.track[index].0 = SelectedTrack.currentLocation
        let gate = SelectedTrack.track.track[index]
        Coords1.setTitle(String(format: "(%.2f,%.2f)",gate.0.latitude, gate.0.longitude), for: .normal)
    }
    @IBAction func SetGateCoords2(_ sender: Any) {
        SelectedTrack.track.track[index].1 = SelectedTrack.currentLocation
        let gate = SelectedTrack.track.track[index]
        Coords2.setTitle(String(format: "(%.2f,%.2f)",gate.1.latitude, gate.1.longitude), for: .normal)
    }
}
