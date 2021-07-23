//
//  User.swift
//  
//
//  Created by Mathew Gacy on 6/29/21.
//

import Foundation

public struct User: Codable, Identifiable, Equatable, Hashable {
    public let id: Int
    public var name: String
    public var username: String
    public var email: String
    public var address: Address?
    public var phone: String?
    public var website: String?
    public var company: Company?

    public init(
        id: Int,
        name: String,
        username: String,
        email: String,
        address: Address?,
        phone: String?,
        website: String?,
        company: Company?
    ) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
}
