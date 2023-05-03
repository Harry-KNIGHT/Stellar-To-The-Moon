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

	func downloadImageToCameraRoll(_ articleMediaUrl: String) {

		DispatchQueue.global(qos: .background).async {
			if let url = URL(string: articleMediaUrl),
				let urlData = NSData(contentsOf: url) {
				let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
				let filePath="\(documentsPath)/tempFile.mp4"
				DispatchQueue.main.async {
					urlData.write(toFile: filePath, atomically: true)
					PHPhotoLibrary.shared().performChanges({
						PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
					}) { completed, error in
						if completed {
							print("Video is saved!")
						}
					}
				}
			}
		}
	}
}
