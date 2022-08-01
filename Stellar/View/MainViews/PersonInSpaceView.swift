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
			ScrollView {
				LazyVStack(alignment: .leading) {
					ForEach(peopleApi.spacePeoples, id: \.self) { p in
						ForEach(p.people, id: \.self) { person in
							NavigationLink(destination: PersonSpaceDetailView(personInSpace: person)) {
								ZStack {
									RoundedRectangle(cornerRadius: 10)
										.frame(maxWidth: .infinity, maxHeight: .infinity)
										.foregroundStyle(.regularMaterial)

									HStack {
										VStack(alignment: .leading) {
											Text(person.name)
												.font(.title3)
												.foregroundColor(.primary)
											Text(person.agency)
												.foregroundColor(.primary)
												.font(.headline)
											Text(person.position)
												.font(.subheadline)
												.foregroundColor(.secondary)
										}.padding()
										Spacer()
									}
								}
							}
						}
					}
				}
				.padding()
				.navigationTitle("Currently in space")
			}
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
