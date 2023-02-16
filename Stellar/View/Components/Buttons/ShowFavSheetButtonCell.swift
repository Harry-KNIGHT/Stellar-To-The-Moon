//
//  ShowFavSheetButtonCell.swift
//  Stellar
//
//  Created by Elliot Knight on 19/11/2022.
//

import SwiftUI

struct ShowFavSheetButtonCell: View {
	@Binding var showFavoritesSheet: Bool

    var body: some View {
		Button(action: {
			showFavoritesSheet.toggle()

		}, label: {
			Label("Add article to favorite", systemImage: "star.fill")
				.navigationButtonLabelStyle()
		})
		.accessibilityLabel("See your favorites astronomy articles.")
		.sheet(isPresented: $showFavoritesSheet) {
			FavoritesArticlesView()
		}
    }
}

struct ShowFavSheetButtonCell_Previews: PreviewProvider {
    static var previews: some View {
		ShowFavSheetButtonCell(showFavoritesSheet: .constant(false))
    }
}
