//
//  ViewController.swift
//  Remote_state
//
//  Created by Apple on 26/04/22.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON


class ViewController: UIViewController {

    @IBOutlet weak var navLeftButton: UIButton!
    @IBOutlet weak var listAndMapButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var dataSearchBar: UISearchBar!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tableListView: UIView!
    
    let baseUrl = "https://api.mystral.in/tt/mobile/logistics/searchTrucks?auth-company=PCH&companyId=33&deactivated=false&key=g2qb5jvucg7j8skpu5q7ria0mu&q-expand=true&q-include=lastRunningState,lastWaypoint"
    var truckData = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialFunctions()
        
    }


}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locationValue.latitude) \(locationValue.longitude)")
    }
}




//MARK: - Functions
extension ViewController {
    
    private func initialFunctions(){
        setupMapView()
        getTruckDetails()
        AddTarget()
    }
    
    private func setupMapView(){
        //Google Maps SDK: COMPASS - Enable
        mapView.settings.compassButton = true
        //Google Maps SDK: USER"S Location - Enable
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        listAndMapButton.tag = 101
    }
    private func AddTarget() {
        listAndMapButton.addTarget(self, action: #selector(listAndMapAction), for: .touchUpInside)
    }
    
    @objc func listAndMapAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        vc.truckData = truckData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func setupMarkers(){
        
        for i in self.truckData["data"].arrayValue {
           let marker = GMSMarker()
           let lat = i["lastWaypoint"]["lat"].doubleValue
           let long = i["lastWaypoint"]["lng"].doubleValue
            
           let truckImage = UIImage(named: "truck")
           let markerView = UIImageView(image: truckImage)

           if i["lastRunningState"]["truckRunningState"].intValue == 0 {
               markerView.tintColor = .systemRed
           }
           else if i["lastRunningState"]["truckRunningState"].intValue  == 1 {
               markerView.tintColor = .systemGreen
           }
           else{
               markerView.tintColor = .systemYellow
           }
           marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
           marker.iconView = markerView
           marker.map = mapView
        }
        
    }
}


//MARK: -   MAP Functions

extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: \(String(describing: place.name))")
                dismiss(animated: true, completion: nil)
                
        self.mapView.clear()
        
        let latitudeData = place.coordinate.latitude
        let longitudeData = place.coordinate.longitude
        
        let coordinates2DView = CLLocationCoordinate2D(latitude: (latitudeData), longitude: (longitudeData))
        
        let marker = GMSMarker()
        marker.position = coordinates2DView
        marker.title = "Location"
        marker.snippet = place.name
        
        let markerImage = UIImage(named: "gm")
        let markerView = UIImageView(image: markerImage)
        marker.iconView = markerView
        marker.map = self.mapView
        
        self.mapView.camera = GMSCameraPosition.camera(withTarget: coordinates2DView, zoom: 15)
        
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        
    }
    
}




//MARK: - API Functions

extension ViewController {
    
    private func getTruckDetails(){
        WebServices.shared.requestToApi(with: baseUrl, urlMethod: .get, params: nil) { jsonDataResponse in
            print("\(jsonDataResponse) API HIT * -->>>>>> Login! got the response \n ")
            self.truckData = JSON(jsonDataResponse)
            DispatchQueue.main.async {
                self.setupMarkers()
            }
        }
    }
    
}
