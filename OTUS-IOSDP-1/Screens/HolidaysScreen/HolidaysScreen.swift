//
//  HolydaysScreen.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 03/07/2021.
//

import SwiftUI
import URLImage

struct HolidaysScreen: View {

    @ObservedObject var viewModel: HolidaysModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        switch viewModel.output {
        case .success(let holidays):
            List(holidays) { holiday in
                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading) {
                        Text(holiday.name)
                        Text(holiday.description)
                            .font(Font.footnote)
                        HStack {
                            
                            ForEach(0..<holiday.type.count, id: \.self) { i in
                                Text(holiday.type[i])
                                    .fontWeight(.light)
                                    .font(Font.footnote)
                                    .foregroundColor(colorScheme == .light ? Color.white : Color.black)
                                    .padding(4)
                                    .background(Color.gray)
                                    .cornerRadius(8)
                            }
                            
                        }
                    }
                    Spacer()
                    Text(holiday.date.string ?? "")
                        .font(Font.footnote)
                }
                
            }

        case .failure(let error):
            Text(error.localizedDescription)
        }
    }
}

fileprivate extension Date {
    var string: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
