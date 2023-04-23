//
//  VideoPlaceHolderCell.swift
//  Stellar
//
//  Created by Elliot Knight on 19/11/2022.
//

import SwiftUI
import StellarMoonKit

struct VideoPlaceHolderCell: View {

	private let linearGradient = LinearGradient(colors: [Color(red: 237/255, green: 116/255, blue: 103/255), .red], startPoint: .top, endPoint: .bottom)
	let article: Article
	
	var body: some View {
		ZStack(alignment: .bottomLeading) {
			ZStack {
				RoundedRectangle(cornerRadius: 0)
					.foregroundStyle(linearGradient)
				Image(systemName: "play.fill")
					.foregroundStyle(.white)
					.font(.system(size: deviceSizeDivisedByTwo))
					.shadow(radius: 5)
			}
			.accessibilityLabel("Video placeholder")
			HStack {
				Text(article.title)
					.lineLimit(1)
					.foregroundStyle(.white)
					.padding(.leading, 4)
				Spacer()
			}
			.padding(.top, 2)
			.background(.linearGradient(colors: [.clear, .black.opacity(0.7)], startPoint: .top, endPoint: .center))
		}
		.border(.black)
		.frame(width: deviceSizeDivisedByTwo, height: deviceSizeDivisedByTwo)
	}
}

struct VideoPlaceHolderCell_Previews: PreviewProvider {
	static var previews: some View {
		VideoPlaceHolderCell(article: .articleSample)
			.previewLayout(.sizeThatFits)
	}
}
