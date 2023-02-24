//
//  SheetButtonsStyle.swift
//  Stellar
//
//  Created by Elliot Knight on 25/01/2023.
//

import SwiftUI

struct NavigationButtonLabelStyle: ViewModifier {
	var font: Font = .title2
	func body(content: Content) -> some View {
		content
			.font(font)
			.foregroundColor(.primary)
	}
}

extension View {
	func navigationButtonLabelStyle(_ font: Font = .title2) -> some View {
		modifier(NavigationButtonLabelStyle(font: font))
	}
}
