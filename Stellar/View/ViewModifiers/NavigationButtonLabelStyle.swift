//
//  SheetButtonsStyle.swift
//  Stellar
//
//  Created by Elliot Knight on 25/01/2023.
//

import SwiftUI

struct NavigationButtonLabelStyle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.title)
			.foregroundColor(.primary)
	}
}

extension View {
	func navigationButtonLabelStyle() -> some View {
		modifier(NavigationButtonLabelStyle())
	}
}
