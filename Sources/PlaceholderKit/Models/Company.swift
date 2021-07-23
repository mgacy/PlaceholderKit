//
//  Company.swift
//  
//
//  Created by Mathew Gacy on 6/29/21.
//

import Foundation

public struct Company: Codable, Equatable, Hashable {
    public var name: String
    public var catchPhrase: String
    public var bs: String

    public init(name: String, catchPhrase: String, bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
}
