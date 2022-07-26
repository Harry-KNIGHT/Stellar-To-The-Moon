//
//  AstronomyModel.swift
//  NasaAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import Foundation

struct NasaAstronomyResponse: Hashable, Codable {
	let copyright: String?
	let date, explanation: String
	let hdurl: String?
	let mediaType, serviceVersion, title: String
	let url: String

	enum CodingKeys: String, CodingKey {
		case copyright, date, explanation, hdurl
		case mediaType = "media_type"
		case serviceVersion = "service_version"
		case title, url
	}
}
