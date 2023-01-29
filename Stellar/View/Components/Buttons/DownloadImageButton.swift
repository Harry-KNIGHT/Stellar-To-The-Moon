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

	@Binding var circleProgress: CGFloat
	@Binding var isImageDowloaded: Bool
	@Binding var isDownloadingImage: Bool

    var body: some View {
		Button(action: {
			downloadImage(article: article, isDownloadingImage: isDownloadingImage, isImageDowloaded: isImageDowloaded)
		}, label: {

			if !isDownloadingImage {
				Image(systemName: "arrow.down.to.line")
					.font(.title2)
					.foregroundColor(.white)
			} else {
				CircularProgressBar(circleProgress: circleProgress, width: 25, height: 25, lineWidth: 4)
			}
		})
		.downloadOrShuffleImageButtonStyle()
    }
	func startLoading() {
		_ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
			withAnimation {
				self.circleProgress += 0.01
				if self.circleProgress >= 0.95 {
					timer.invalidate()
				}
			}
		}
	}

	func downloadImage(article: AstronomyArticleModel, isDownloadingImage: Bool, isImageDowloaded: Bool) {
		Task {
			do {
				self.isDownloadingImage.toggle()
				self.startLoading()

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
		DownloadImageButton(article: .astronomySample, circleProgress: .constant(0.0), isImageDowloaded: .constant(false), isDownloadingImage: .constant(false))
			.environmentObject(AstronomyDetailViewModel())
    }
}
