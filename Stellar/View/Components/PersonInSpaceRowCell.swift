//
//  PersonInSpaceRowCell.swift
//  Stellar
//
//  Created by Elliot Knight on 01/09/2022.
//

import SwiftUI

struct PersonInSpaceRowCell: View {
	var hasGotImage: Bool = true
	var name: String
	var agency: String
	var position: String
	var image: String
	var imageHeight: CGFloat = 60
	var corner: CGFloat = 0

	var body: some View {
		if hasGotImage {
			HStack {
				PersonInformations(name: name, agency: agency, position: position)
				Spacer()
				Image(image)
					.resizable()
					.scaledToFit()
					.frame(height: imageHeight)
					.clipShape(RoundedRectangle(cornerRadius: corner, style: .continuous))
			}.padding(.horizontal, 8)
		} else {
			PersonInformations(name: name, agency: agency, position: position)
		}
	}
}

struct PersonInSpaceRowCell_Previews: PreviewProvider {
	static var previews: some View {
		Group {
		PersonInSpaceRowCell(name: "Thomas Pesquet", agency: "ESA", position: "Commander", image: "ESAL")
			.previewLayout(.sizeThatFits)
			PersonInSpaceRowCell(name: "Thomas Pesquet", agency: "ESA", position: "Commander", image: "ESAL")
				.previewLayout(.sizeThatFits)
				.preferredColorScheme(.dark)
		}
	}
}

struct PersonInformations: View {
	var name: String
	var agency: String
	var position: String
	var body: some View {
		VStack(alignment: .leading) {
			Text(name)
				.font(.title3)
				.foregroundColor(.primary)
			Text(agency)
				.foregroundColor(.primary)
				.font(.headline)
			Text(position)
				.font(.subheadline)
				.foregroundColor(.secondary)
		}
		.padding(8)
	}
}
