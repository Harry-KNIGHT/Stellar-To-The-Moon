//
//  HeadbandsDetailActions.swift
//  Stellar
//
//  Created by Elliot Knight on 22/02/2023.
//
import StellarMoonKit
import SwiftUI

struct HeadbandsDetailActions: View {
	let article: Article
	@Binding var isImageDowloaded: Bool
	@Binding var isDownloadingImage: Bool

	@Binding var showShareImage: Bool

	@StateObject var downloadImageVm = DownloadImageViewModel()
	@State var sharedImage: UIImage? = nil

	var body: some View {
		HStack {
			Spacer()

			AddFavoriteButtonCell(article: article)
			Spacer()

			DownloadImageButton(
				article: article,
				isImageDowloaded: $isImageDowloaded,
				isDownloadingImage: $isDownloadingImage
			)
			Spacer()

			Button(action: {
				Task {
					guard let imageHdUrl = article.hdurl else { return }
					guard let imageUrl = URL(string: imageHdUrl) else { return }
					downloadImageVm.downloadImageForSharing(url: imageUrl) { image in
						showShareImage = true
						sharedImage = image
					}
				}
			}, label: {
				Image(systemName: "square.and.arrow.up")
			})

			.navigationButtonLabelStyle(.title)
			.sheet(isPresented: $showShareImage) {
				// Provide the items you want to share as an array, e.g., [yourImage]
				if let image = sharedImage {
					ActivityViewController(activityItems: ["\(article.title)", image])
				} else {
					Text("Error: Image not available for sharing.")
				}
			}
			Spacer()
		}
	}
}

struct HeadbandsDetailActions_Previews: PreviewProvider {
	static var previews: some View {
		HeadbandsDetailActions(
			article: .articleSample,
			isImageDowloaded: .constant(false),
			isDownloadingImage: .constant(false),
			showShareImage: .constant(false)
		)
		.environmentObject(DownloadImageViewModel())
		.environmentObject(FavoriteViewModel())
	}
}
