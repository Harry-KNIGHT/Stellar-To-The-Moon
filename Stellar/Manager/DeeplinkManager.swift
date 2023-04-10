//
//  DeeplinkManager.swift
//  Stellar
//
//  Created by Elliot Knight on 10/04/2023.
//

import Foundation

class DeepLinkManager: ObservableObject {
	@Published var selectedArticleID: String?

	func handleDeepLink(url: URL) {
		if let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
		   components.scheme == "myapp",
		   components.host == "article",
		   let articleID = components.path?.replacingOccurrences(of: "/", with: "") {
			selectedArticleID = articleID
		}
	}
}

// URL = stellar://article/23-02-2023
