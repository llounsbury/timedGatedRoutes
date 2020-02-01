//
//  TrackGateScreen.swift
//  GPS_test
//
//  Created by Lee Lounsbury on 1/31/20.
//  Copyright © 2020 Lee Lounsbury. All rights reserved.
//

import UIKit

class TrackGateScreen: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension TrackGateScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SelectedTrack.track.track.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gate = SelectedTrack.track.track[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "GateCell") as! TrackGateCell
        cell.setGate(gate: gate, index: indexPath.row)
        return cell
    }
}

