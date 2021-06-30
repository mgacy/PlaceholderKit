//
//  Address.swift
//  
//
//  Created by Mathew Gacy on 6/29/21.
//

import Foundation

public struct Address: Codable, Equatable, Hashable {
    public let street: String
    public let suite: String
    public let city: String
    public let zipcode: String
    public let geo: Geo

    public init(street: String, suite: String, city: String, zipcode: String, geo: Geo) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
}

extension Address {

    // swiftlint:disable:next type_name
    public struct Geo: Codable, Equatable, Hashable {
        public let lat: String
        public let lng: String

        public init(lat: String, lng: String) {
            self.lat = lat
            self.lng = lng
        }
    }
}
