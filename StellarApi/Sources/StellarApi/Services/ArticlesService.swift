//
//  ArticlesService.swift
//  
//
//  Created by Elliot Knight on 23/07/2023.
//

import Foundation

public struct ArticlesService {

	public init() { }

	public func getArticles(_ daysInterval: Double = 100) async throws -> [ArticleDTO]  {
		let url = "https://apod.ellanan.com/api?start_date=\(Date.now.daysAgo(daysInterval))"
		
		guard let url = URL(string: url) else {
			throw ArticleServiceError.urlNotFound
		}
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
			throw ArticleServiceError.badHttpResponse
		}
		
		do {
			return try JSONDecoder().decode([ArticleDTO].self, from: data)
		} catch {
			throw ArticleServiceError.cantDecodeResponse
		}
	}
}


enum ArticleServiceError: Error {
	case urlNotFound
	case badHttpResponse
	case cantDecodeResponse

}

