//
//  DownloadImageViewModel.swift
//  Stellar
//
//  Created by Elliot Knight on 22/08/2022.
//

import Foundation
import UIKit
import StellarMoonKit
import PhotosUI

final class DownloadImageViewModel: ObservableObject {
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

	enum DownloadError: Error {
		case invalidUrl
		case downloadFailed
		case writeToFileFailed
		case assetCreationFailed
	}

	func downloadImageToCameraRoll(_ articleMediaUrl: String) async throws {
		guard let url = URL(string: articleMediaUrl) else {
			throw DownloadError.invalidUrl
		}

		let (data, response) = try await URLSession.shared.data(from: url)

		guard let httpResponse = response as? HTTPURLResponse,
			  (200...299).contains(httpResponse.statusCode) else {
			throw DownloadError.downloadFailed
		}

		let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
		let filePath = "\(documentsPath)/tempFile.mp4"

		do {
			try data.write(to: URL(fileURLWithPath: filePath))
		} catch {
			throw DownloadError.writeToFileFailed
		}

		do {
			try await PHPhotoLibrary.shared().performChanges {
				let request = PHAssetCreationRequest.forAsset()
				request.addResource(with: .video, fileURL: URL(fileURLWithPath: filePath), options: .none)
			}
		} catch {
			print(error.localizedDescription)
			throw DownloadError.assetCreationFailed
		}
	}
}
