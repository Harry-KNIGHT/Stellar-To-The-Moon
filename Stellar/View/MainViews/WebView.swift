//
//  WebView.swift
//  Stellar
//
//  Created by Elliot Knight on 01/08/2022.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

	var url: URL

	func makeUIView(context: Context) -> WKWebView {
		return WKWebView()
	}

	func updateUIView(_ webView: WKWebView, context: Context) {
		let request = URLRequest(url: url)
		webView.load(request)
	}
}
