//
//  SpaceNewsModel.swift
//  Stellar
//
//  Created by Elliot Knight on 04/08/2022.
//

import Foundation

// MARK: - NewsResponseElement
struct NewsResponseElement: Hashable, Codable {
	let id: Int
	let title: String
	let url: String
	let imageURL: String
	let newsSite: NewsSite
	let summary, publishedAt, updatedAt: String
	let featured: Bool
	let launches: [Launch]
	let events: [Event]

	enum CodingKeys: String,Hashable, CodingKey {
		case id, title, url
		case imageURL = "imageUrl"
		case newsSite, summary, publishedAt, updatedAt, featured, launches, events
	}
}

// MARK: - Event
struct Event: Hashable, Codable {
	let id: Int
	let provider: Provider
}

enum Provider: String, Hashable, Codable {
	case launchLibrary2 = "Launch Library 2"
}

// MARK: - Launch
struct Launch: Hashable, Codable {
	let id: String
	let provider: Provider
}

enum NewsSite: String, Hashable, Codable {
	case arstechnica = "Arstechnica"
	case nasa = "NASA"
	case nasaSpaceflight = "NASA Spaceflight"
	case spaceNews = "SpaceNews"
	case spaceflightNow = "Spaceflight Now"
	case teslarati = "Teslarati"
}

typealias NewsResponse = [NewsResponseElement]
