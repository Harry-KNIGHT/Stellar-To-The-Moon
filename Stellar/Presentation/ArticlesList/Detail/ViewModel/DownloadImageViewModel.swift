//
//  DownloadImageViewModel.swift
//  Stellar
//
//  Created by Elliot Knight on 22/08/2022.
//

import Foundation
import UIKit
import Domain

class DownloadImageViewModel: ObservableObject {
	func downloadImageToCameraRoll(from url: String) async throws -> UIImage {
		guard let url = URL(string: url) else {
//			throw ApiError.urlNotFound
			print("Error")
		}
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			if let image = UIImage(data: data) {
				return image
			} else {
//				throw ApiError.noDataForImage
				print("Error")
			}
		} catch {
			print("Error")
		}
	}
}
