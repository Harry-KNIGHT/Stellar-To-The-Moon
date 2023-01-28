//
//  SearchArticleByDateButtonView.swift
//  Stellar
//
//  Created by Elliot Knight on 28/01/2023.
//

import SwiftUI

struct SearchArticleByDateButtonView: View {
	@EnvironmentObject var searchDateVM: SearchDateArticleViewModel
	@Binding var date: Date
	
    var body: some View {
		Button(action: {
			searchDateVM.searchOneArticle(date: date)
		}, label: {
			Text("Search")
				.frame(maxWidth: .infinity)
		})
		.buttonStyle(.borderedProminent)
    }
}

struct SearchArticleByDateButtonView_Previews: PreviewProvider {
    static var previews: some View {
		SearchArticleByDateButtonView(date: .constant(.now))
			.environmentObject(SearchDateArticleViewModel())
    }
}
