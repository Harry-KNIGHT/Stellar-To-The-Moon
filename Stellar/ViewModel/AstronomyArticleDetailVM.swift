//
//  AstronomyArticleDetailVM.swift
//  Stellar
//
//  Created by Elliot Knight on 22/08/2022.
//

import Foundation
import UIKit
import StellarMoonKit

class AstronomyDetailViewModel: ObservableObject {
	@Published var nasaReponses: [AstronomyArticleModel] = []

	func getAstronomyArticle() {
		Task {
			do {
				try await self.nasaReponses.append(AstronomyApi.nasaApi())
			} catch {
				print("Error: \(error.localizedDescription)")
			}
		}
	}

	func getImage(from url: String) async throws -> UIImage {
		guard let url = URL(string: url) else {
			throw ApiError.urlNotFound
		}
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			if let image = UIImage(data: data) {
				return image
			} else {
				throw ApiError.noDataForImage
			}
		} catch {
			throw ApiError.cantFetchImage
		}
		
	}
}
