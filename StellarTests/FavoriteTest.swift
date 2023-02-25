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
		favoriteVM.favoriteAstronomyArticles = [Article]()

    }

    override func tearDownWithError() throws {
		favoriteVM = nil
    }

	func test_emptyFavorite() throws {
		XCTAssertEqual(favoriteVM.favoriteAstronomyArticles.count, 0)
		XCTAssertTrue(favoriteVM.favoriteAstronomyArticles.isEmpty)
	}

	func test_addFavorite() throws {
		let _ = favoriteVM.favoriteAstronomyArticles.append(.articleSample)

		XCTAssertEqual(favoriteVM.favoriteAstronomyArticles.count, 1)
		XCTAssertFalse(favoriteVM.favoriteAstronomyArticles.isEmpty)
	}

	func test_removeFavorite() throws {
		let _ = favoriteVM.favoriteAstronomyArticles.append(.articleSample)
		let _ = favoriteVM.deletSelectedFavorite(article: favoriteVM.favoriteAstronomyArticles[0])

		XCTAssertEqual(favoriteVM.favoriteAstronomyArticles.count, 0)
		XCTAssertTrue(favoriteVM.favoriteAstronomyArticles.isEmpty)
	}

	func test_addOrDeletFavorite() throws {
		// Add astronomy article sample on the array
		let _: Void = favoriteVM.addOrDeletFavorite(article: .articleSample)
		XCTAssertTrue(favoriteVM.favoriteAstronomyArticles.contains(.articleSample))
		XCTAssertEqual(favoriteVM.favoriteAstronomyArticles.count, 1)
		XCTAssertNotEqual(favoriteVM.favoriteAstronomyArticles.count, 10)

		// Remove astronomy article sample from the array
		let _: Void = favoriteVM.addOrDeletFavorite(article: .articleSample)
		XCTAssertFalse(favoriteVM.favoriteAstronomyArticles.contains(.articleSample))
		XCTAssertEqual(favoriteVM.favoriteAstronomyArticles.count, 0)
		XCTAssertNotEqual(favoriteVM.favoriteAstronomyArticles.count, 5)
	}
}
