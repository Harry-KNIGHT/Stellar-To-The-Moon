//
//  FavoriteTest.swift
//  StellarTests
//
//  Created by Elliot Knight on 01/01/2023.
//

import XCTest
import StellarMoonKit
@testable import Stellar

final class FavoriteTest: XCTestCase {
	var favoriteVM: FavoriteViewModel!
    override func setUpWithError() throws {
		favoriteVM = FavoriteViewModel()
		favoriteVM.favoriteArticles = [Article]()

    }

    override func tearDownWithError() throws {
		favoriteVM = nil
    }

	func test_emptyFavorite() throws {
		XCTAssertEqual(favoriteVM.favoriteArticles.count, 0)
		XCTAssertTrue(favoriteVM.favoriteArticles.isEmpty)
	}

	func test_addFavorite() throws {
		let _ = favoriteVM.favoriteArticles.append(.articleSample)

		XCTAssertEqual(favoriteVM.favoriteArticles.count, 1)
		XCTAssertFalse(favoriteVM.favoriteArticles.isEmpty)
	}

	func test_removeFavorite() throws {
		let _ = favoriteVM.favoriteArticles.append(.articleSample)

		XCTAssertEqual(favoriteVM.favoriteArticles.count, 0)
		XCTAssertTrue(favoriteVM.favoriteArticles.isEmpty)
	}

	func test_addOrDeletFavorite() throws {
		// Add astronomy article sample on the array
		let _: Void = favoriteVM.addOrDeletFavorite(article: .articleSample)
		XCTAssertTrue(favoriteVM.favoriteArticles.contains(.articleSample))
		XCTAssertEqual(favoriteVM.favoriteArticles.count, 1)
		XCTAssertNotEqual(favoriteVM.favoriteArticles.count, 10)

		// Remove astronomy article sample from the array
		let _: Void = favoriteVM.addOrDeletFavorite(article: .articleSample)
		XCTAssertFalse(favoriteVM.favoriteArticles.contains(.articleSample))
		XCTAssertEqual(favoriteVM.favoriteArticles.count, 0)
		XCTAssertNotEqual(favoriteVM.favoriteArticles.count, 5)
	}
}
