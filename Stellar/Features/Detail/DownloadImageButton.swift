//
//  DownloadImageButton.swift
//  Stellar
//
//  Created by Elliot Knight on 02/12/2022.
//

import SwiftUI
import Domain

struct DownloadImageButton: View {
	let article: ArticlePresentation
	@ObservedObject private var downloadImageVm = DownloadImageViewModel()

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
		.customButtonStyle(.title)
	}

	// TODO: À RETIRER DE LA VUE!
	func downloadImage(article: ArticlePresentation, isDownloadingImage: Bool, isImageDowloaded: Bool) {
		Task {
			do {
				self.isDownloadingImage = true
				Task {
					let imageSaver = ImageSaver()
					let image = try await downloadImageVm.downloadImageToCameraRoll(from: article.mediaUrl)
					imageSaver.writeToPhotoAlbum(image: image)
					self.isImageDowloaded = true
					self.isDownloadingImage = false
				}
			}
		}
	}
}

struct DownloadImageButton_Previews: PreviewProvider {
	static var previews: some View {
		DownloadImageButton(
			article: .imageArticleSample,
			isImageDowloaded: .constant(false),
			isDownloadingImage: .constant(false)
		)
		.environmentObject(DownloadImageViewModel())
	}
}
