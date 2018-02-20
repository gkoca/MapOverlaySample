//
//  ViewController.swift
//  MapOverlaySample
//
//  Created by Gökhan KOCA on 20.02.2018.
//  Copyright © 2018 gkoca. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
	
	var allCountries: GeoModel?
	let ids = ["AZE", "IRQ", "JOR", "KAZ", "KGZ", "PAK", "SYR", "TJK", "TKM", "TUR", "UZB"]
	@IBOutlet weak var mapView: MKMapView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib. // allCountries["TUR"]?.features.first?.geometry
		getCountryData()
		
		if let countries = allCountries {
			
//			for country in countries.features {
//				for locations in country.geometry.locations {
//					mapView.add(MKPolygon(coordinates: locations, count: locations.count))
//				}
//			}
			// ""
			if let c = countries.features.filter({ $0.properties.id == "SYR" }).first {
				for locations in c.geometry.locations {
					mapView.add(MKPolygon(coordinates: locations, count: locations.count))
				}
			}
		}
		
//		if let tur = allCoun{
//			for locations in tur.locations {
//				mapView.add(MKPolygon(coordinates: locations, count: locations.count))
//			}
//		}
		
	}
	
	func getCountryData() {
		if let content = Bundle.main.url(forResource: "countries", withExtension: "geojson") {
			if let data = try? Data(contentsOf: content) {
				populateGeoData(data)
			} else {
				print("no data")
			}
		}
	}
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		if overlay is MKPolygon {
			let polygonView = MKPolygonRenderer(overlay: overlay)
			polygonView.fillColor = UIColor.cocacolaRed()
			polygonView.strokeColor = UIColor.lightGray
			polygonView.lineWidth = 2
			return polygonView
		}
		return MKOverlayRenderer()
	}
	
	func populateGeoData(_ data: Data) {
			if let countries = try? GeoModel(data: data) {
				allCountries = countries
			}
		print(allCountries?.features.count ?? 0)
	}
	
	/*
	var locations: [[CLLocationCoordinate2D]] {
	get {
	var locati = [[CLLocationCoordinate2D]]()
	for coordinate in coordinates {
	var loca = [CLLocationCoordinate2D]()
	for coor in coordinate {
	var lat: Double = 0
	var lon: Double = 0
	var flag = false
	for index in 0..<coor.count {
	switch coor[index] {
	case .double(let value):
	flag = true
	switch index {
	case 0:
	lat = value
	break
	case 1:
	lon = value
	break
	default: break
	}
	break
	case .doubleArray(let values):
	flag = false
	loca.append(CLLocationCoordinate2D(latitude: values.last!, longitude: values.first!))
	break
	}
	}
	if flag {
	loca.append(CLLocationCoordinate2D(latitude: lat, longitude: lon))
	}
	
	}
	locati.append(loca)
	}
	return locati
	}
	}
	*/
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}

