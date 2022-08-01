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
										if person.agency.lowercased() == "nasa" {
											PersonInSpaceRow(name: person.name, agency: person.agency, position: person.position)
											Spacer()
											Image("NASAL")
												.resizable()
												.scaledToFit()
												.frame(height: 60)



										} else if person.agency.lowercased() == "roscosmos" {


											PersonInSpaceRow(name: person.name, agency: person.agency, position: person.position)
											Spacer()
											Image("ROSCOSMOSL")
												.resizable()
												.scaledToFit()
												.frame(height: 60)
										} else if person.agency.lowercased() == "esa" {

											PersonInSpaceRow(name: person.name, agency: person.agency, position: person.position)
											Spacer()
											Image("ESAL")
												.resizable()
												.scaledToFit()
												.frame(height: 60)


										} else if person.agency.lowercased() == "cnsa" {
											PersonInSpaceRow(name: person.name, agency: person.agency, position: person.position)
											Spacer()
											Image("CNSAL")
												.resizable()
												.scaledToFit()
												.frame(height: 60)


										} else {
											PersonInSpaceRow(name: person.name, agency: person.agency, position: person.position)
										}


									}.padding(.horizontal)
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

struct PersonInSpaceRow: View {
	var name: String
	var agency: String
	var position: String
	var body: some View {
		VStack(alignment: .leading) {
			Text(name)
				.font(.title3)
				.foregroundColor(.primary)
			Text(agency)
				.foregroundColor(.primary)
				.font(.headline)
			Text(position)
				.font(.subheadline)
				.foregroundColor(.secondary)
		}.padding(.vertical)
	}
}
