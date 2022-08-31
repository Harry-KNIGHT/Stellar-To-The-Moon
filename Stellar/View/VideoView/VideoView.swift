//
//  VideoView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import WebKit

struct VideoView: UIViewRepresentable {

	let videoID: String

	func makeUIView(context: Context) -> WKWebView {
		return WKWebView()
	}

	func updateUIView(_ uiView: WKWebView, context: Context) {
		guard let url =  URL(string: videoID) else { return }

		uiView.scrollView.isScrollEnabled = false
		uiView.load(URLRequest(url: url))
	}
}
