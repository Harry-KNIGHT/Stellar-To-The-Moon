//
//  PeopleInSpaceApi.swift
//  Stellar
//
//  Created by Elliot Knight on 28/07/2022.
//

import Foundation
import StellarMoonKit

class PersonInSpaceViewModel: ObservableObject {
	@Published public var spacePeoples: [PeopleInSpaceResponse] = []

	@MainActor func getPersonInsSpace() async throws {
		do {
			try await self.spacePeoples.append(PersonInSpaceApi.fetchPersonInSpace())
		} catch {
			throw error
		}
	}
}
