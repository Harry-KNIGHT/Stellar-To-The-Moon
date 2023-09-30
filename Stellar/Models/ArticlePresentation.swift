//
//  ArticlePresentation.swift
//  Stellar
//
//  Created by Elliot Knight on 30/09/2023.
//

import Foundation

class ArticlePresentation: ObservableObject, Identifiable, Codable, Equatable  {

	static func == (lhs: ArticlePresentation, rhs: ArticlePresentation) -> Bool {
		return lhs.id == rhs.id && lhs.title == rhs.title &&
		lhs.copyright == rhs.copyright && lhs.explanation == rhs.explanation &&
		lhs.mediaUrl == rhs.mediaUrl && lhs.isFavorite == rhs.isFavorite
	}
	

	// MARK: Properties

	var id = UUID()
	let title: String
	let copyright: String?
	let explanation: String
	let date: String
//	let mediaType: MediaType
	let mediaUrl: String
	@Published var isFavorite: Bool


	// MARK: Initializer

	public init(
		title: String,
		copyright: String?,
		explanation: String,
		date: String,
//		mediaType: MediaType,
		mediaUrl: String,
		isFavorite: Bool
	) {
		self.title = title
		self.copyright = copyright
		self.explanation = explanation
		self.date = date
//		self.mediaType = mediaType
		self.mediaUrl = mediaUrl
		self.isFavorite = isFavorite
	}

	 enum CodingKeys: String, CodingKey {
		case title
		case copyright
		case explanation
		case date
//		case mediaType = "media_type"
		case mediaUrl = "url"
		case isFavorites
	}

	// This will be deleted when we will use swiftdata instead of userdefault.

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		title = try container.decode(String.self, forKey: .title)
		copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
		explanation = try container.decode(String.self, forKey: .explanation)
		date = try container.decode(String.self, forKey: .date)
		mediaUrl = try container.decode(String.self, forKey: .mediaUrl)
		isFavorite = try container.decode(Bool.self, forKey: .isFavorites)
	}

	func encode(to encoder: Encoder) throws {
		  var container = encoder.container(keyedBy: CodingKeys.self)
		  try container.encode(title, forKey: .title)
		  try container.encode(copyright, forKey: .copyright)
		  try container.encode(explanation, forKey: .explanation)
		  try container.encode(date, forKey: .date)
		  try container.encode(mediaUrl, forKey: .mediaUrl)
		  try container.encode(isFavorite, forKey: .isFavorites)
	  }
}


extension ArticlePresentation {
	static var imageArticleSample = ArticlePresentation(
		title: "Tycho and Clavius at Dawn",
		copyright: "Eduardo\nSchaberger Poupeau",
		explanation: "South is up in this dramatic telescopic view of the lunar terminator and the Moon's rugged southern highlands.",
		date: "2022-07-16",
//		mediaType: .image,
		mediaUrl: "https://apod.nasa.gov/apod/image/2207/Dawn-in-Clavius-Tycho-07-07-22_1024.jpg",
		isFavorite: true
	)
}
