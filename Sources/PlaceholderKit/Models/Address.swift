//
//  Address.swift
//  
//
//  Created by Mathew Gacy on 6/29/21.
//

import Foundation

public struct Address: Codable, Equatable, Hashable {
    public var street: String
    public var suite: String
    public var city: String
    public var zipcode: String
    public var geo: Geo

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
        public var lat: String
        public var lng: String

        public init(lat: String, lng: String) {
            self.lat = lat
            self.lng = lng
        }
    }
}
