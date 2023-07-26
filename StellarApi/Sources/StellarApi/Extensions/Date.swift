//
//  Date.swift
//  
//
//  Created by Elliot Knight on 23/07/2023.
//

import Foundation

extension Date {
	// MARK: - Fetch articles from one date in days.

	public func daysAgo(_ daysInterval: Double) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let oneDayInSec: Double = 86400

		// Convert days in seconds for epoch format
		let dayIntervalInSeconds: Double = (oneDayInSec * daysInterval)
		let todayInEpoch: Double = Date().timeIntervalSince1970

		let daysIntervalInSecondsMinusTodayInEpoch = (todayInEpoch - dayIntervalInSeconds)
		let daysIntervalAgoEpochFormat: Date = Date(timeIntervalSince1970: daysIntervalInSecondsMinusTodayInEpoch)
		let convertEpochToStringformat = dateFormatter.string(from: daysIntervalAgoEpochFormat)

		return convertEpochToStringformat
	}
}
