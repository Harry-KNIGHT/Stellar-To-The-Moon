//
//  ShowFavSheetButtonCell.swift
//  Stellar
//
//  Created by Elliot Knight on 19/11/2022.
//

import SwiftUI

struct ShowFavSheetButtonCell: View {
	@Binding var showSheet: Bool

    var body: some View {
		Button(action: {
			showSheet.toggle()

		}, label: {
			Label("Add article to favorite", systemImage: "star.fill")
				.font(.title3)
				.foregroundColor(.primary)
		})
		.accessibilityLabel("See your favorites astronomy articles.")
		.sheet(isPresented: $showSheet) {
			FavoritesArticleList()
		}
    }
}

struct ShowFavSheetButtonCell_Previews: PreviewProvider {
    static var previews: some View {
		ShowFavSheetButtonCell(showSheet: .constant(false))
    }
}
