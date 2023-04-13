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
				self.showShareImage = true
			}, label: {
				Image(systemName: "plus.circle")
			})

			.navigationButtonLabelStyle(.title)
			.sheet(isPresented: $showShareImage) {
					   // Provide the items you want to share as an array, e.g., [yourImage]
					   ActivityViewController(activityItems: ["Sharing this image from my app", UIImage(systemName: "photo")!])
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

struct ActivityViewController: UIViewControllerRepresentable {
	let activityItems: [Any]
	let applicationActivities: [UIActivity]? = nil

	func makeUIViewController(context: Context) -> UIActivityViewController {
		let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
		return controller
	}

	func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
		// No updates needed
	}
}
