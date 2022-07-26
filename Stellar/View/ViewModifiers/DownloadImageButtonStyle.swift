//
//  DownloadImageButtonStyle.swift
//  Stellar
//
//  Created by Elliot Knight on 02/12/2022.
//

import SwiftUI

struct DownloadImageButtonStyle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.accessibilityLabel("Download image button")
			.buttonStyle(.borderedProminent)
			.clipShape(Circle())
			.foregroundColor(.blue)
			.overlay {
				Circle()
					.stroke(.white, lineWidth: 0.4)
			}
			.shadow(color: .blue, radius: 10)
			.padding([.bottom, .trailing])
	}
}
