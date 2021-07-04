//
//  CardModifier.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(16.0)
            .shadow(color: Color.black.opacity(0.25),
                    radius: 11,
                    x: 0.0,
                    y: 2.0)
            .padding(EdgeInsets(
                        top: 0,
                        leading: 8,
                        bottom: 0,
                        trailing: 8))
    }
}
