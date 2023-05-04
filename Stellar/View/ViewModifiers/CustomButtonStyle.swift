//
//  CustomButtonStyle.swift
//  Stellar
//
//  Created by Elliot Knight on 25/01/2023.
//

import SwiftUI

struct CustomButtonStyle: ViewModifier {
	var font: Font = .title2
	func body(content: Content) -> some View {
		content
			.font(font)
			.foregroundColor(.primary)
	}
}

extension View {
	func customButtonStyle(_ font: Font = .title2) -> some View {
		modifier(CustomButtonStyle(font: font))
	}
}
