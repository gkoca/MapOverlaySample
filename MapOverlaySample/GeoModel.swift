//
//  GeoModel.swift
//  MapOverlaySample
//
//  Created by Gökhan KOCA on 20.02.2018.
//  Copyright © 2018 gkoca. All rights reserved.
//

import Foundation
import MapKit

class GeoModel: Codable {
	let type: String
	let features: [Feature]
	
	enum CodingKeys: String, CodingKey {
		case type = "type"
		case features = "features"
	}
	
	init(type: String, features: [Feature]) {
		self.type = type
		self.features = features
	}
}

class Feature: Codable {
	let type: String
	let id: String
	let properties: Properties
	let geometry: Geometry
	
	enum CodingKeys: String, CodingKey {
		case type = "type"
		case id = "id"
		case properties = "properties"
		case geometry = "geometry"
	}
	
	init(type: String, id: String, properties: Properties, geometry: Geometry) {
		self.type = type
		self.id = id
		self.properties = properties
		self.geometry = geometry
	}
}

class Geometry: Codable {
	let type: String
	let coordinates: [[[Coordinate]]]
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
	/*
	
	var locations: [[CLLocationCoordinate2D]] {
	get {
	var locati = [[CLLocationCoordinate2D]]()
	for coordinate in coordinates {
	var loca = [CLLocationCoordinate2D]()
	for coor in coordinate {
	loca.append(CLLocationCoordinate2D(latitude: coor.first!, longitude: coor.last!))
	}
	locati.append(loca)
	}
	return locati
	}
	}
	
	*/
	enum CodingKeys: String, CodingKey {
		case type = "type"
		case coordinates = "coordinates"
	}
	
	init(type: String, coordinates: [[[Coordinate]]]) {
		self.type = type
		self.coordinates = coordinates
	}
}

enum Coordinate: Codable {
	case double(value: Double)
	case doubleArray(values: [Double])
	
	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if let x = try? container.decode(Double.self) {
			self = .double(value: x)
			return
		}
		if let x = try? container.decode([Double].self) {
			self = .doubleArray(values: x)
			return
		}
		throw DecodingError.typeMismatch(Coordinate.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Coordinate"))
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		switch self {
		case .double(let x):
			try container.encode(x)
		case .doubleArray(let x):
			try container.encode(x)
		}
	}
}

class Properties: Codable {
	let name: String
	
	enum CodingKeys: String, CodingKey {
		case name = "name"
	}
	
	init(name: String) {
		self.name = name
	}
}

// MARK: Convenience initializers

extension GeoModel {
	convenience init(data: Data) throws {
		let me = try JSONDecoder().decode(GeoModel.self, from: data)
		self.init(type: me.type, features: me.features)
	}
	
	convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}
	
	convenience init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}
	
	func jsonData() throws -> Data {
		return try JSONEncoder().encode(self)
	}
	
	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

extension Feature {
	convenience init(data: Data) throws {
		let me = try JSONDecoder().decode(Feature.self, from: data)
		self.init(type: me.type, id: me.id, properties: me.properties, geometry: me.geometry)
	}
	
	convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}
	
	convenience init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}
	
	func jsonData() throws -> Data {
		return try JSONEncoder().encode(self)
	}
	
	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

extension Geometry {
	convenience init(data: Data) throws {
		let me = try JSONDecoder().decode(Geometry.self, from: data)
		self.init(type: me.type, coordinates: me.coordinates)
	}
	
	convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}
	
	convenience init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}
	
	func jsonData() throws -> Data {
		return try JSONEncoder().encode(self)
	}
	
	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

extension Properties {
	convenience init(data: Data) throws {
		let me = try JSONDecoder().decode(Properties.self, from: data)
		self.init(name: me.name)
	}
	
	convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}
	
	convenience init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}
	
	func jsonData() throws -> Data {
		return try JSONEncoder().encode(self)
	}
	
	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}


