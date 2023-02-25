//
//  DownloadImageButton.swift
//  Stellar
//
//  Created by Elliot Knight on 02/12/2022.
//

import SwiftUI
import StellarMoonKit
import ActivityIndicatorView

struct DownloadImageButton: View {
	let article: Article
	@EnvironmentObject var astronomyVM: AstronomyDetailViewModel

	@Binding var isImageDowloaded: Bool
	@Binding var isDownloadingImage: Bool

	var body: some View {
		Button(action: {
			downloadImage(article: article, isDownloadingImage: isDownloadingImage, isImageDowloaded: isImageDowloaded)
		}, label: {
			if isDownloadingImage {
				ProgressView()
			} else if isImageDowloaded {
				Image(systemName: "checkmark.square")
			} else {
				Image(systemName: "square.and.arrow.down")
			}
		})
		.navigationButtonLabelStyle(.title)
	}


	func downloadImage(article: Article, isDownloadingImage: Bool, isImageDowloaded: Bool) {
		Task {
			do {
				self.isDownloadingImage = true

				guard let urlString = article.hdurl else {
					throw ApiError.urlNotFound
				}
				Task {
					let imageSaver = ImageSaver()
					let image = try await astronomyVM.getImage(from: urlString)
					imageSaver.writeToPhotoAlbum(image: image)
					self.isImageDowloaded = true
					self.isDownloadingImage = false
				}
			} catch {
				print("Error \(error.localizedDescription)")
			}
		}
	}
}

struct DownloadImageButton_Previews: PreviewProvider {
	static var previews: some View {
		DownloadImageButton(
			article: .articleSample,
			isImageDowloaded: .constant(false),
			isDownloadingImage: .constant(false)
		)
		.environmentObject(AstronomyDetailViewModel())
	}
}
