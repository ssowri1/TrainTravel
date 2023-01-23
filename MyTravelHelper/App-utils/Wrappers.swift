//
//  Wrappers.swift
//  MyTravelHelper
//
//  Created by Sowrirajan S on 23/01/23.
//  Copyright © 2023 Sample. All rights reserved.
//

import Foundation

extension UserDefaults {
    @UserDefault(key: "favourites_collection", defaultValue: [])
    static var favourites: [String]
}

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
