//
//  GeoModel.swift
//  MapOverlaySample
//
//  Created by Gökhan KOCA on 20.02.2018.
//  Copyright © 2018 gkoca. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let geoModel = try GeoModel(json)

import Foundation

struct GeoModel: Codable {
	let type: String
	let features: [Feature]
	
	enum CodingKeys: String, CodingKey {
		case type = "type"
		case features = "features"
	}
}

struct Feature: Codable {
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
}

struct Geometry: Codable {
	let type: String
	let coordinates: [[[Double]]]
	
	enum CodingKeys: String, CodingKey {
		case type = "type"
		case coordinates = "coordinates"
	}
}

struct Properties: Codable {
	let name: String
	
	enum CodingKeys: String, CodingKey {
		case name = "name"
	}
}

// MARK: Convenience initializers

extension GeoModel {
	init(data: Data) throws {
		self = try JSONDecoder().decode(GeoModel.self, from: data)
	}
	
	init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}
	
	init(fromURL url: URL) throws {
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
	init(data: Data) throws {
		self = try JSONDecoder().decode(Feature.self, from: data)
	}
	
	init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}
	
	init(fromURL url: URL) throws {
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
	init(data: Data) throws {
		self = try JSONDecoder().decode(Geometry.self, from: data)
	}
	
	init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}
	
	init(fromURL url: URL) throws {
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
	init(data: Data) throws {
		self = try JSONDecoder().decode(Properties.self, from: data)
	}
	
	init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}
	
	init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}
	
	func jsonData() throws -> Data {
		return try JSONEncoder().encode(self)
	}
	
	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

