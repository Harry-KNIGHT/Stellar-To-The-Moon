//
//  LoadingArticleImagePlaceholder.swift
//  Stellar
//
//  Created by Elliot Knight on 02/12/2022.
//

import SwiftUI

struct LoadingArticleImagePlaceholder: View {
	@Binding var isLoadingVisible: Bool
	var body: some View {
		ZStack {
			Rectangle()
				.frame(minHeight: 200, maxHeight: 350)
				.foregroundStyle(.regularMaterial)

			ProgressView()
				.frame(width: 100, height: 50)
				.foregroundColor(.primary)
				.accessibilityLabel("Loading image")
		}
	}
}

struct LoadingArticleImagePlaceholder_Previews: PreviewProvider {
	static var previews: some View {
		LoadingArticleImagePlaceholder(isLoadingVisible: .constant(false))
	}
}
