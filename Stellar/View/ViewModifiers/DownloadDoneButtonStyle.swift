//
//  DownloadDoneButtonStyle.swift
//  Stellar
//
//  Created by Elliot Knight on 02/12/2022.
//

import SwiftUI

struct DownloadDoneButtonStyle: ViewModifier {
	@Binding var animate: Bool
	func body(content: Content) -> some View {
		content
			.accessibilityLabel("Download done.")
			.buttonStyle(.borderedProminent)
			.clipShape(Circle())
			.tint(.green)
			.overlay {
				Circle()
					.stroke(.white, lineWidth: 0.4)
			}
			.shadow(color: .green, radius: 10)
			.padding([.bottom, .trailing])
			.opacity(animate ? 0 : 1)
			.animation(.easeInOut(duration: 2).delay(1), value: animate ? 0 : 1)
	}
}
