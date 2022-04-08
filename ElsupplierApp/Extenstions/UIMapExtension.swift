//
//  UIMapExtension.swift
//
//  Created by Ahmed Madeh
//

import UIKit
import MapKit

extension MKMapView {
    
    func zoomToLocation(location : CLLocation,level:Float = -1, animated: Bool = false) {
        
        let viewRegion =  MKCoordinateRegion(center: location.coordinate, latitudinalMeters: CLLocationDistance(level), longitudinalMeters: CLLocationDistance(level))
        
        let region = MKCoordinateRegion(center: location.coordinate,span: self.region.span)
        self.setRegion(level == -1 ? region : viewRegion , animated: animated)
    }
    func drawRouts(routs : [MKRoute]) {
        for route in routs {
            
            if !self.overlays(in: .aboveRoads).isEmpty {
                self.removeOverlays(self.overlays(in: .aboveRoads))
            }
            self.addOverlay(route.polyline, level:.aboveRoads)
        }
        
    }
    var isRegionChangedByUser : Bool {
        
        let view = self.subviews.first
        
        for recognizer in (view?.gestureRecognizers)! {
            if recognizer.state == .began || recognizer.state == .ended || recognizer.state == .failed {
                return true
            }
            
        }
        
        return false;
    }
    
    
    func addAnnotation(lat: Double, long: Double, title: String) {
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.addAnnotation(annotation)
    }
    
}
extension MKPointAnnotation {
    convenience init(coordinate: CLLocationCoordinate2D) {
        self.init()
        self.coordinate = coordinate
    }
}
extension Array where Element: CLLocation {
    func midLocationFor(mapView: MKMapView) -> CLLocation {
        let midX = compactMap {mapView.convert($0.coordinate, toPointTo: mapView).x}.reduce(0, +) / CGFloat(count)
        let midY = compactMap {mapView.convert($0.coordinate, toPointTo: mapView).y}.reduce(0, +) / CGFloat(count)
        let coordinate = mapView.convert(CGPoint(x: midX, y: midY), toCoordinateFrom: mapView)
        return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    func containsPoint(point: CLLocation, forMapVew: MKMapView) -> Bool {
        if self.count <= 1 {
            return false
        }
        let p = UIBezierPath()
        let firstPoint = forMapVew.convert(self.first!.coordinate, toPointTo: forMapVew)
        p.move(to: firstPoint)
        for index in 1...count-1 {
            let point = forMapVew.convert(self[index].coordinate, toPointTo: forMapVew)
            p.addLine(to: point)
        }
        p.close()
        return p.contains(forMapVew.convert(point.coordinate, toPointTo: forMapVew))
    }
}


