//
//  NetworkImage.swift
//  Stellar
//
//  Created by Elliot Knight on 15/05/2023.
//

import SwiftUI

struct NetworkImage: View {
	let url: URL?

	var body: some View {
		Group {
			if let url = url, let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
				Image(uiImage: uiImage)
					.resizable()
					.scaledToFill()
			}
			else {
				ProgressView()
			}
		}
	}
}
