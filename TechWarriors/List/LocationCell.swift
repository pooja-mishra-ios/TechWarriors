//
//  LocationCell.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 07/07/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit
import MapKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(latitude: String, longitude: String) {
        let lat = (latitude as NSString).floatValue
        let long = (longitude as NSString).floatValue
        let coords = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coords, span: span)
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coords
        mapView.addAnnotation(annotation)
    }
    
}
