//
//  MapViewController.swift
//  GPS_test
//
//  Created by Lee Lounsbury on 1/29/20.
//  Copyright © 2020 Lee Lounsbury. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var MapFrame: MKMapView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapFrame.delegate = self
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(SelectedTrack.track.track[0].0.latitude,SelectedTrack.track.track[0].0.longitude), latitudinalMeters: 200, longitudinalMeters: 200)
        MapFrame.setRegion(region, animated: true)
        
        for gate in SelectedTrack.track.track {
            var points = [CLLocationCoordinate2D]()
            points.append(CLLocationCoordinate2DMake(gate.0.latitude, gate.0.longitude))
            points.append(CLLocationCoordinate2DMake(gate.1.latitude, gate.1.longitude))
            let annotation = MKPolyline(coordinates: points, count: 2)
            MapFrame.addOverlay(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if (overlay is MKPolyline) {
            let pr = MKPolylineRenderer(overlay: overlay)
            pr.strokeColor = UIColor.red.withAlphaComponent(0.5)
            pr.lineWidth = 5
            return pr
        }
        return MKPolylineRenderer(overlay: overlay)
    }
}
