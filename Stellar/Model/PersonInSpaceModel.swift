//
//  PersonInSpaceMode.swift
//  Stellar
//
//  Created by Elliot Knight on 28/07/2022.
//

import Foundation

// MARK: - PeopleInSpaceResponse
struct PeopleInSpaceResponse: Hashable, Codable {
	let number, issExpedition: Int
	let expeditionPatch: String
	let expeditionURL: String
	let expeditionImage: String
	let people: [Person]

	enum CodingKeys: String, CodingKey {
		case number
		case issExpedition = "iss_expedition"
		case expeditionPatch = "expedition_patch"
		case expeditionURL = "expedition_url"
		case expeditionImage = "expedition_image"
		case people
	}
}

// MARK: - Person
struct Person: Hashable, Codable {
	let id: Int
	let name, country, flagCode, agency: String
	let position: String
	let spacecraft: Spacecraft
	let launched: Int
	let iss: Bool
	let daysInSpace: Int
	let url: String
	let image: String

	enum CodingKeys: String, CodingKey {
		case id, name, country
		case flagCode = "flag_code"
		case agency, position, spacecraft, launched, iss
		case daysInSpace = "days_in_space"
		case url, image
	}
}

enum Spacecraft: String, Hashable, Codable {
	case crew4Dragon = "Crew-4 Dragon"
	case shenzhou14 = "Shenzhou 14"
	case soyuzMS21 = "Soyuz MS-21"
}
