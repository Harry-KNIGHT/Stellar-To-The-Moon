//
//  BackgroundImageCell.swift
//  Stellar
//
//  Created by Elliot Knight on 20/11/2022.
//

import SwiftUI
import StellarMoonKit

struct BackgroundImageCell: View {
	let article: AstronomyArticleModel
	@Environment(\.colorScheme) var colorScheme
    var body: some View {
		AsyncImage(url: URL(string: article.url)) { image in
			image
				.resizable()
				.scaledToFill()
				.blur(radius: 2, opaque: true)
		} placeholder: {
			Rectangle()
				.fill(colorScheme == .dark ? .black : .white)
		}
    }
}

struct BackgroundImageCell_Previews: PreviewProvider {
    static var previews: some View {
		BackgroundImageCell(article: .astronomySample)
    }
}
