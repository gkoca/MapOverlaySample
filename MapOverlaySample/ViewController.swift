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
	
	var allCountries = [String:GeoModel]()
	
	@IBOutlet weak var mapView: MKMapView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		getCountryData()
		if let tur = allCountries["TUR"]?.features.first?.geometry {
			for locations in tur.locations {
				mapView.add(MKPolygon(coordinates: locations, count: locations.count))
			}
		}
		
	}
	
	func getCountryData() {
		var datas = [Data]()
		if let countries = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: "") {
			for country in countries {
				datas.append(try! Data(contentsOf: country))
			}
		}
		populateGeoData(datas)
	}
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		if overlay is MKPolygon {
			let polygonView = MKPolygonRenderer(overlay: overlay)
			polygonView.fillColor = UIColor.cocacolaRed(alpha: 1)
			polygonView.strokeColor = UIColor.lightGray
			polygonView.lineWidth = 5
			return polygonView
		}
		return MKOverlayRenderer()
	}
	
	func populateGeoData(_ datas: [Data]) {
		for data in datas {
			if let country = try? GeoModel(data: data) {
				allCountries[(country.features.first?.id)!] = country
			} else {
				print("missin data index \(String(describing: datas.index(of: data)))")
			}
		}
		print(allCountries.count)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}

