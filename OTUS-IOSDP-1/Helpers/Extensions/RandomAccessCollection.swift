//
//  RandomAccessCollection.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 24/07/2021.
//

import Foundation

extension RandomAccessCollection where Self.Element: Identifiable {
    
    public func isLast<Item: Identifiable>(_ item: Item) -> Bool {
        guard isEmpty == false else {
            return false
        }

        guard let itemIndex = lastIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }

        let distance = self.distance(from: itemIndex, to: endIndex)
        return distance == 1
    }
    
}
