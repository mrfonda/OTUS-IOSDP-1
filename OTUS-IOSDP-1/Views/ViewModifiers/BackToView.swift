//
//  BackToView.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 27/07/2021.
//

import SwiftUI

struct BackToView: ViewModifier {
    let function: () -> Void

    func body(content: Content) -> some View {
        content.gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global).onEnded { value in
            let horizontalAmount = value.translation.width as CGFloat
            let verticalAmount = value.translation.height as CGFloat
             
            if abs(horizontalAmount) > abs(verticalAmount) && horizontalAmount > 0 {
                function()
            }
        })
    }
}
