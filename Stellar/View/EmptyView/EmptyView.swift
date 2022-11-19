//
//  EmptyView.swift
//  Stellar
//
//  Created by Elliot Knight on 27/07/2022.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
		VStack {
			Text("Aucun favoris ")
			Image(systemName: "star.slash")
		}
		.font(.largeTitle)
		.foregroundStyle(.secondary)
		.accessibilityLabel("You don't have any favorite.")
	}
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
