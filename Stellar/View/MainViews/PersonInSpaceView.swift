//
//  PeopleInSpaceView.swift
//  Stellar
//
//  Created by Elliot Knight on 28/07/2022.
//

import SwiftUI

struct PersonInSpaceView: View {
	@EnvironmentObject public var peopleApi: PersonInSpaceApi
	var body: some View {
		NavigationView {
			List {
				ForEach(peopleApi.spacePeoples, id: \.self) { p in
					ForEach(p.people, id: \.self) { person in
						NavigationLink(destination: PersonSpaceDetailView(personInSpace: person)) {
							VStack(alignment: .leading) {
								Text(person.name)
									.font(.title3)
								Text(person.agency)
									.font(.headline)
								Text(person.position)
									.font(.subheadline)
									.foregroundColor(.secondary)
							}
						}
					}
				}
			}.navigationTitle("Peoples in space")
		}
		.task {
			do {
				try await peopleApi.fetchPersonInSpace()
			} catch {
				print("Error append, \(error.localizedDescription)")
			}
		}

	}
}

struct PersonInSpaceView_Previews: PreviewProvider {
	static var previews: some View {
		PersonInSpaceView()
			.environmentObject(PersonInSpaceApi())
	}
}
