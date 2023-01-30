//
//  CopyrightStyle.swift
//  Stellar
//
//  Created by Elliot Knight on 02/12/2022.
//

import SwiftUI
import StellarMoonKit

struct CopyrightStyle: ViewModifier {
	let article: AstronomyArticleModel = .astronomySample

	func body(content: Content) -> some View {
		content
			.foregroundColor(.white)
			.padding(4)
			.padding(.top, 8)
			.background(LinearGradient(colors: [.clear, .black.opacity(0.6)], startPoint: .top, endPoint: .center))
			.accessibilityLabel("Photo taken by \(article.copyright ?? "unknown")")
	}
}

extension View {
	func copyrightStyle() -> some View {
		modifier(CopyrightStyle())
	}
}
