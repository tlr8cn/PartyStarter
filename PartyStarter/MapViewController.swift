//
//  MapViewController.swift
//  PartyStarter
//
//  Created by Tyler Robinson on 4/6/16.
//  Copyright © 2016 Tyler Robinson. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

var partyRoute : MKRoute?


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let locationManager =  CLLocationManager()

    @IBOutlet weak var mapToParty: MKMapView!
    
    var routeToParty : MKRoute?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ask for authorization from the user
        self.locationManager.requestAlwaysAuthorization()
        
        //for use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [CLLocation]) {
        
        print ("HELP ME")
        var userLocation:CLLocation = locations[0] as! CLLocation
        let long = userLocation.coordinate.longitude
        let lat = userLocation.coordinate.latitude
        
        var currentPoint = MKPointAnnotation()
        var partyPoint = MKPointAnnotation()
    
        currentPoint.coordinate = CLLocationCoordinate2DMake(lat, long)
        currentPoint.title = "Your Location"
        mapToParty.addAnnotation(currentPoint)
        
        //eventually grab this data from database--hardcoded in for now
        partyPoint.coordinate = CLLocationCoordinate2DMake(38.394395, -81.896702)
        partyPoint.title = "Party Location"
        mapToParty.addAnnotation(partyPoint)
        
        mapToParty.centerCoordinate = partyPoint.coordinate
        mapToParty.delegate = self
        
        mapToParty.setRegion(MKCoordinateRegionMake(partyPoint.coordinate, MKCoordinateSpanMake(0.7,0.7)), animated: true)
        
        var directionsRequest = MKDirectionsRequest()
        let currentMark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(currentPoint.coordinate.latitude, currentPoint.coordinate.longitude), addressDictionary: nil)
        let partyMark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(partyPoint.coordinate.latitude, partyPoint.coordinate.longitude), addressDictionary: nil)
        
        directionsRequest.source = MKMapItem(placemark: currentMark)
        directionsRequest.destination = MKMapItem(placemark: partyMark)
        
        directionsRequest.transportType = .Automobile
        
        var directions = MKDirections(request: directionsRequest)
        
        directions.calculateDirectionsWithCompletionHandler {
            response, error in
            
            guard let response = response else {
                print("there was an error!")
                return
            }
            self.routeToParty = response.routes[0] as? MKRoute
            self.mapToParty.addOverlay((self.routeToParty?.polyline)!)
            
        }
        
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        var myLineRenderer = MKPolylineRenderer(polyline: (routeToParty?.polyline)!)
        myLineRenderer.strokeColor = UIColor.redColor()
        myLineRenderer.lineWidth = 3
        return myLineRenderer
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //dispose of any recources
    }
    
    
    
}
