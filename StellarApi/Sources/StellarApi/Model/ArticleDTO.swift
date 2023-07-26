//
//  ArticleDTO.swift
//  
//
//  Created by Elliot Knight on 19/07/2023.
//

import Foundation

// MARK: - Article model

public struct ArticleDTO: Codable{

	// MARK: Initializer

	public init(
		title: String,
		copyright: String?,
		explanation: String,
		date: String,
		serviceVersion: ServiceVersion,
		mediaType: MediaType,
		mediaUrl: String
	) {
		self.title = title
		self.copyright = copyright
		self.explanation = explanation
		self.date = date
		self.serviceVersion = serviceVersion
		self.mediaType = mediaType
		self.mediaUrl = mediaUrl
	}

	// MARK: Properties

	public let title: String
	public let copyright: String?
	public let explanation: String
	public let date: String
	public let mediaType: MediaType
	public let serviceVersion: ServiceVersion
	public let mediaUrl: String

	public enum CodingKeys: String, CodingKey {
		case title
		case copyright
		case explanation
		case date
		case serviceVersion = "service_version"
		case mediaType = "media_type"
		case mediaUrl = "url"
	}
}

// MARK: MediaType enum

public enum MediaType: String, Codable {
	case image = "image"
	case video = "video"
}

// MARK: ServiceVersion enum

public enum ServiceVersion: String, Codable {
	case v1 = "v1"
}

typealias ArticleModel = [ArticleDTO]
