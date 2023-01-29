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
			Image(systemName: "shuffle")
				.padding(9)
				.foregroundColor(.white)
				.font(.title)
		})
		.downloadOrShuffleImageButtonStyle(isInDetailView: false)
    }
}

struct GenerateRandomArticleButton_Previews: PreviewProvider {
    static var previews: some View {
        GenerateRandomArticleButton()
			.environmentObject(SearchDateArticleViewModel())
    }
}
