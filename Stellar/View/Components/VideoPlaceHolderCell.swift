//
//  VideoPlaceHolderCell.swift
//  Stellar
//
//  Created by Elliot Knight on 19/11/2022.
//

import SwiftUI

struct VideoPlaceHolderCell: View {
	let size: CGFloat = 90
	let linearGradient = LinearGradient(colors: [Color(red: 237/255, green: 116/255, blue: 103/255), .red], startPoint: .top, endPoint: .bottom)
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 10)
				.frame(width: size, height: size)
				.foregroundStyle(linearGradient)
			Image(systemName: "play.fill")
				.foregroundStyle(.white)
				.font(.system(size: size / 2))
				.shadow(radius: 5)
		}
		.accessibilityLabel("Video placeholder")
	}
}

struct VideoPlaceHolderCell_Previews: PreviewProvider {
	static var previews: some View {
		VideoPlaceHolderCell()
	}
}
