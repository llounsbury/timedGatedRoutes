//
//  MapViewController.swift
//  GPS_test
//
//  Created by Lee Lounsbury on 1/29/20.
//  Copyright © 2020 Lee Lounsbury. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var MapFrame: MKMapView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        var region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(SelectedTrack.track.track[0].0.latitude,SelectedTrack.track.track[0].0.longitude), latitudinalMeters: 200, longitudinalMeters: 200)
        MapFrame.setRegion(region, animated: true)
        
        for gate in SelectedTrack.track.track {
            var annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(gate.0.latitude,gate.0.longitude)
            MapFrame.addAnnotation(annotation)
        }
        
        
        

        // Do any additional setup after loading the view.
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
