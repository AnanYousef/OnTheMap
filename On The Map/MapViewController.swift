//
//  MapViewController.swift
//  On The Map
//
//  Created by Anan Yousef on 05/01/2021.
//

import UIKit
import MapKit

class MapViewController: Base, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStudentsList()
    }
    
    private func getStudentsList(_ reset: Bool = false) {
        getStudentsList(successHandler: {studentLocationList in self.addStudentsPointAnnotation(studentLocationList)}, reset: reset)
    }

    private func addStudentsPointAnnotation(_ studentLocationList: [StudentLocation]) {
        
        let anotations: [MKAnnotation] = studentLocationList.map { studentLocation in
            
            let point = MKPointAnnotation()
            
            point.title = parseStundentName(studentLocation)
            
            point.subtitle = studentLocation.mediaURL
            
            point.coordinate = CLLocationCoordinate2D(latitude: studentLocation.latitude, longitude: studentLocation.longitude)
            
            return point
        }
        
        map.addAnnotations(anotations)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView!.rightCalloutAccessoryView = UIButton(type: .infoLight)
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let subtitle: String = view.annotation?.subtitle as? String else { return }
        
        openBroweserIfValidMediaURL(subtitle)
        
    }
    
    @IBAction func logout(_ sender: Any) {
        performLogout()
    }
    @IBAction func reload(_ sender: Any) {
        getStudentsList(true)
    }
    
    @IBAction func location(_ sender: Any) {
        AddLocation()
    }
    
}


