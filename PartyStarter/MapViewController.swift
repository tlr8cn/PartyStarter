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


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let locationManager =  CLLocationManager()

    @IBOutlet weak var mapToParty: MKMapView!
    
    var routeToParty : MKRoute?
    
    var has_centered = false;
    
    
    var party_long : CLLocationDegrees?
    
    var party_lat : CLLocationDegrees?
    
    var directionsRequest = MKDirectionsRequest()
    
    /*
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(partyAddress)
        print(partyTitle)
        

        streetAddressToCoordinates(partyAddress!)
        
        
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
        
        var userLocation:CLLocation = locations[0] as! CLLocation
        let long = userLocation.coordinate.longitude
        let lat = userLocation.coordinate.latitude
        
        var currentPoint = MKPointAnnotation()
        
    
        currentPoint.coordinate = CLLocationCoordinate2DMake(lat, long)
        currentPoint.title = "Your Location"
        mapToParty.addAnnotation(currentPoint)
        
        //eventually grab this data from database--hardcoded in for now
        
        if(!has_centered) {
            mapToParty.centerCoordinate = currentPoint.coordinate
            mapToParty.delegate = self
        
            mapToParty.setRegion(MKCoordinateRegionMake(currentPoint.coordinate, MKCoordinateSpanMake(0.07,0.07)), animated: true)
            
            has_centered = true;
        }
        
        
        let currentMark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(currentPoint.coordinate.latitude, currentPoint.coordinate.longitude), addressDictionary: nil)

        
        directionsRequest.source = MKMapItem(placemark: currentMark)
        
        
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
    
    
    
    @IBAction func getDirections(sender: AnyObject) {
        self.performSegueWithIdentifier("GetDirections", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GetDirections" {
            if let DVC = segue.destinationViewController as? DirectionsViewController {
                DVC.theRoute = routeToParty
            } else {
                print("Data NOT Passed!")
            }
        } else { print("Id doesnt match with Storyboard segue Id") }
    }
    
    
    func streetAddressToCoordinates(address : String) {
        var geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(partyAddress!, completionHandler: {(placemarks, error) -> Void in
            
            if((error) != nil) {
                print("Error: ", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                self.party_lat = coordinates.latitude
                self.party_long = coordinates.longitude
                
                print(self.party_lat)
                print (self.party_long)
                var partyPoint = MKPointAnnotation()
                
                partyPoint.coordinate = CLLocationCoordinate2DMake(self.party_lat!, self.party_long!)
                partyPoint.title = "Party Location"
                self.mapToParty.addAnnotation(partyPoint)

                
                let partyMark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(partyPoint.coordinate.latitude, partyPoint.coordinate.longitude), addressDictionary: nil)
                self.directionsRequest.destination = MKMapItem(placemark: partyMark)
                
            }
            
        })
    }
    
    
}
