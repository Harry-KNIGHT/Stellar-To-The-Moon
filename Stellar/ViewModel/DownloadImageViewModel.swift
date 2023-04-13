//
//  DownloadImageViewModel.swift
//  Stellar
//
//  Created by Elliot Knight on 22/08/2022.
//

import Foundation
import UIKit
import StellarMoonKit

class DownloadImageViewModel: ObservableObject {
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
	
	func downloadImageForSharing(url: URL, completion: @escaping (UIImage?) -> Void) {
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data, error == nil, let image = UIImage(data: data) else {
				completion(nil)
				return
			}
			completion(image)
		}.resume()
	}
}
