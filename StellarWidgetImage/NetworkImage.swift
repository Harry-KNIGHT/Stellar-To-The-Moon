//
//  NetworkImage.swift
//  Stellar
//
//  Created by Elliot Knight on 17/12/2022.
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
