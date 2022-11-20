//
//  VideoPlaceHolderCell.swift
//  Stellar
//
//  Created by Elliot Knight on 19/11/2022.
//

import SwiftUI
import StellarMoonKit

struct VideoPlaceHolderCell: View {
	let size = (deviceWidth / 2)
	let linearGradient = LinearGradient(colors: [Color(red: 237/255, green: 116/255, blue: 103/255), .red], startPoint: .top, endPoint: .bottom)
	let article: AstronomyArticleModel
	var body: some View {
		ZStack(alignment: .bottomLeading) {
			ZStack {
				RoundedRectangle(cornerRadius: 0)
					.frame(width: size, height: size)
					.foregroundStyle(linearGradient)
				Image(systemName: "play.fill")
					.foregroundStyle(.white)
					.font(.system(size: size / 2))
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
			.background(.linearGradient(colors: [.clear, .secondary.opacity(0.7)], startPoint: .top, endPoint: .center))
		}
	}
}

struct VideoPlaceHolderCell_Previews: PreviewProvider {
	static var previews: some View {
		VideoPlaceHolderCell(article: .astronomySample)
	}
}
