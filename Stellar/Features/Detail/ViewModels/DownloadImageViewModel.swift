//
//  DownloadImageViewModel.swift
//  Stellar
//
//  Created by Elliot Knight on 26/07/2023.
//

import UIKit
import Foundation

final class DownloadImageViewModel: ObservableObject {
	func downloadImageToCameraRoll(from url: String) async throws -> UIImage {
		guard let url = URL(string: url) else {
			throw ImageDownloaderError.urlNotfound
		}
		let (data, response) = try await URLSession.shared.data(from: url)

		guard let httpResponse = response as? HTTPURLResponse,
			  (200...299).contains(httpResponse.statusCode) else {
			throw ImageDownloaderError.httpResponse
		}
		
		do {
			if let image = UIImage(data: data) {
				return image
			} else {
				throw ImageDownloaderError.UIImageNotConverting
			}
		} catch {
			throw ImageDownloaderError.noImageData
		}
	}
}

enum ImageDownloaderError: Error {
	case urlNotfound
	case httpResponse
	case UIImageNotConverting
	case noImageData
}
