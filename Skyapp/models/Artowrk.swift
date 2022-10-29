//
//  Artwork.swift
//  skygazeapp
//
//  Created by Riyad Anabtawi on 09/08/22.
//  Copyright © 2022 Riyad Anabtawi. All rights reserved.
//

import MapKit

class Artwork: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let discipline: String?
  let coordinate: CLLocationCoordinate2D

  init(
    title: String?,
    locationName: String?,
    discipline: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate

    super.init()
  }

  var subtitle: String? {
    return locationName
  }
}
