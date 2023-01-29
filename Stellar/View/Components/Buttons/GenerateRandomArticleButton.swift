//
//  GenerateRandomArticleButton.swift
//  Stellar
//
//  Created by Elliot Knight on 28/01/2023.
//

import SwiftUI

struct GenerateRandomArticleButton: View {
	@EnvironmentObject var generateArticleVM: SearchDateArticleViewModel
    var body: some View {
		Button(action: {
			generateArticleVM.generateOneArticle()
		}, label: {
			Text("Generate random image")
				.font(.title3)
				.fontWeight(.semibold)
				.frame(maxWidth: .infinity)
		})
		.buttonStyle(.borderedProminent)
		.shadow(radius: 3)
    }
}

struct GenerateRandomArticleButton_Previews: PreviewProvider {
    static var previews: some View {
        GenerateRandomArticleButton()
			.environmentObject(SearchDateArticleViewModel())
    }
}
