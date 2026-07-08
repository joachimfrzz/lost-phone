//
//  VendoredUberEatsMapView.swift
//  food-delivery-ui-kit-v1
//
//  Created by Sopheamen VAN on 24/5/25.
//
import SwiftUI
import MapKit

// MARK: - VendoredUberEatsMapView
struct VendoredUberEatsMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var polyline: MKPolyline?
    @Binding var startAnnotation: MKPointAnnotation?
    @Binding var endAnnotation: MKPointAnnotation?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.isUserInteractionEnabled = false
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.setRegion(region, animated: true)
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)

        if let poly = polyline {
            mapView.addOverlay(poly)
            mapView.setVisibleMapRect(poly.boundingMapRect, edgePadding: .init(top: 20, left: 20, bottom: 20, right: 20), animated: true)
        }

        if let start = startAnnotation {
            mapView.addAnnotation(start)
            mapView.selectAnnotation(start, animated: false)
        }

        if let end = endAnnotation {
            mapView.addAnnotation(end)
            mapView.selectAnnotation(end, animated: false)
        }
    }

    func makeCoordinator() -> VendoredUberEatsCoordinator {
        VendoredUberEatsCoordinator()
    }

    class VendoredUberEatsCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .systemGreen
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer()
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation { return nil }

            let identifier = annotation.title ?? "Annotation"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier ?? "")
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                if annotation.title == "Start" {
                    view?.image = UIImage(systemName: "moped.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
                } else if annotation.title == "Destination" {
                    view?.image = UIImage(systemName: "mappin.circle.fill")?.withTintColor(.blue, renderingMode: .alwaysOriginal)
                }
                view?.canShowCallout = false
            } else {
                view?.annotation = annotation
            }
            return view
        }
    }
}

// MARK: - Polyline Extension
extension MKPolyline {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: self.pointCount)
        self.getCoordinates(&coords, range: NSRange(location: 0, length: self.pointCount))
        return coords
    }
}
