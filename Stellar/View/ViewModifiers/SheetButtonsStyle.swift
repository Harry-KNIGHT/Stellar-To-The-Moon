//
//  SheetButtonsStyle.swift
//  Stellar
//
//  Created by Elliot Knight on 25/01/2023.
//

import SwiftUI

struct SheetButtonsStyle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.title3)
			.foregroundColor(.primary)
	}
}

extension View {
	func sheetButtonsStyle() -> some View {
		modifier(SheetButtonsStyle())
	}
}
