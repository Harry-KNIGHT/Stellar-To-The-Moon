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
	let article: AstronomyArticleModel
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
			}
			   else {

			Image(systemName: "square.and.arrow.down")
		}
		})

		.navigationButtonLabelStyle()
    }


	func downloadImage(article: AstronomyArticleModel, isDownloadingImage: Bool, isImageDowloaded: Bool) {
		Task {
			do {
				self.isDownloadingImage.toggle()

				guard let urlString = article.hdurl else {
					throw ApiError.urlNotFound
				}
				Task {
					let imageSaver = ImageSaver()
					let image = try await astronomyVM.getImage(from: urlString)
					imageSaver.writeToPhotoAlbum(image: image)
					self.isImageDowloaded.toggle()
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
			article: .astronomySample,
			isImageDowloaded: .constant(false),
			isDownloadingImage: .constant(false)
		)
			.environmentObject(AstronomyDetailViewModel())
    }
}
