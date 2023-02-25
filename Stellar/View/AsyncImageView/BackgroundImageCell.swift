//
//  BackgroundImageCell.swift
//  Stellar
//
//  Created by Elliot Knight on 20/11/2022.
//

import SwiftUI
import StellarMoonKit
import CachedAsyncImage

struct BackgroundImageCell: View {
	let article: Article
	@Environment(\.colorScheme) var colorScheme
    var body: some View {
		CachedAsyncImage(url: URL(string: article.url), urlCache: .imageCache) { image in
			image
				.resizable()
				.scaledToFill()
				.blur(radius: 2, opaque: true)
				.ignoresSafeArea(edges: .bottom)
		} placeholder: {
			Rectangle()
				.fill(colorScheme == .dark ? .black : .white)
		}
    }
}

struct BackgroundImageCell_Previews: PreviewProvider {
    static var previews: some View {
		BackgroundImageCell(article: .articleSample)
    }
}
