//
//  PeopleInSpaceView.swift
//  Stellar
//
//  Created by Elliot Knight on 28/07/2022.
//

import SwiftUI

struct PersonInSpaceView: View {
	@ObservedObject public var peopleApi = PersonInSpaceViewModel()
	var body: some View {
		NavigationView {
			ScrollView {
				LazyVStack(alignment: .leading) {
					ForEach(peopleApi.spacePeoples, id: \.self) { person in
						ForEach(person.people, id: \.self) { person in
							NavigationLink(destination: PersonSpaceDetailView(personInSpace: person)) {
								ZStack {
									RoundedRectangle(cornerRadius: 10)
										.frame(maxWidth: .infinity, maxHeight: .infinity)
										.foregroundStyle(.regularMaterial)
									if person.agency.lowercased() == "nasa" {

										PersonInSpaceRowCell(name: person.name, agency: person.agency, position: person.position, image: "NASAL")

									} else if person.agency.lowercased() == "roscosmos" {

										PersonInSpaceRowCell(name: person.name, agency: person.agency, position: person.position, image: "ROSCOSMOSL")

									} else if person.agency.lowercased() == "esa" {

										PersonInSpaceRowCell(name: person.name, agency: person.agency, position: person.position, image: "ESAL", imageHeight: 30)

									} else if person.agency.lowercased() == "cnsa" {

										PersonInSpaceRowCell(name: person.name, agency: person.agency, position: person.position, image: "CNSAL", imageHeight: 50, corner: 10)

									} else {
										PersonInSpaceRowCell(hasGotImage: false, name: person.name, agency: person.agency, position: person.position, image: "")
									}
								}
							}
						}
					}
				}
				.padding()
				.navigationTitle("Currently in space")
				.navigationBarTitleDisplayMode(.inline)
			}
		}
		.task {
			do {
				if peopleApi.spacePeoples.isEmpty {
					try await peopleApi.getPersonInsSpace()
				} else {
					print("Data feched")
				}
			} catch {
				print("Error append, \(error.localizedDescription)")
			}
		}

	}
}

struct PersonInSpaceView_Previews: PreviewProvider {
	static var previews: some View {
		PersonInSpaceView()
			.environmentObject(PersonInSpaceViewModel())
	}
}
