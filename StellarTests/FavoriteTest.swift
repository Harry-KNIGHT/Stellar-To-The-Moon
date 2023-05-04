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
		let _ = favoriteVM.favoriteArticles.append(.imageArticleSample)

		XCTAssertEqual(favoriteVM.favoriteArticles.count, 1)
		XCTAssertFalse(favoriteVM.favoriteArticles.isEmpty)
	}

	func test_given_favoritesArticleIsEmpty() throws {
		favoriteVM.favoriteArticles = []

		XCTAssertEqual(favoriteVM.favoriteArticles.count, 0)
		XCTAssertTrue(favoriteVM.favoriteArticles.isEmpty)
	}

	func test_addOrDeletFavorite() throws {
		// Add astronomy article sample on the array
		let _: Void = favoriteVM.addOrDeletFavorite(article: .imageArticleSample)
		XCTAssertTrue(favoriteVM.favoriteArticles.contains(.imageArticleSample))
		XCTAssertEqual(favoriteVM.favoriteArticles.count, 1)
		XCTAssertNotEqual(favoriteVM.favoriteArticles.count, 10)

		// Remove astronomy article sample from the array
		let _: Void = favoriteVM.addOrDeletFavorite(article: .imageArticleSample)
		XCTAssertFalse(favoriteVM.favoriteArticles.contains(.imageArticleSample))
		XCTAssertEqual(favoriteVM.favoriteArticles.count, 0)
		XCTAssertNotEqual(favoriteVM.favoriteArticles.count, 5)
	}

	func test_given_arrayWithOneArticle_when_deletIt_then_articleArrayIsEmpty() {

		// GIVEN
		favoriteVM.addOrDeletFavorite(article: .imageArticleSample)

		// WHEN
		favoriteVM.addOrDeletFavorite(article: .imageArticleSample)

		// THEN
		XCTAssertEqual(favoriteVM.favoriteArticles.count, 0)
	}

	func test_given_addArticle_when_deletAttOssets_then_arrayIsEmpty() {
		// GIVEN
		favoriteVM.favoriteArticles = [.imageArticleSample, .videoArticleSample]

		// WHEN
		let indexToRemove = IndexSet([0])

		favoriteVM.deletFavorite(at: indexToRemove)

		XCTAssertEqual(favoriteVM.favoriteArticles.count, 1)
	}
}
