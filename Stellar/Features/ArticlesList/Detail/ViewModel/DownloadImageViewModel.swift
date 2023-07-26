//
//  DownloadImageViewModel.swift
//  Stellar
//
//  Created by Elliot Knight on 22/08/2022.
//

import Foundation
import UIKit
import Domain

final class DownloadImageViewModel: ObservableObject {
	public func downloadImageToCameraRoll(from url: String) async throws -> UIImage {
		guard let url = URL(string: url) else {
			throw DownloadImageError.urlNotFound
		}
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			if let image = UIImage(data: data) {
				return image
			} else {
				throw DownloadImageError.emptyImageData
			}
		} catch {
			return UIImage.checkmark
		}
	}
}

enum DownloadImageError: Error {
	case urlNotFound
	case emptyImageData
}
