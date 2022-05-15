//
//  SheetView.swift
//  MurrayStudio
//
//  Created by Stefano Mondino on 14/05/22.
//

import Foundation
import SwiftUI


struct SheetView<Content: View>: View {

    @State private var currentIndex: Int? = nil
    
    let items: [SheetElement]
    @ViewBuilder let contents: (Int) -> Content
    
    init(items: [SheetElement], @ViewBuilder contents: @escaping (Int) -> Content) {
        self.items = items
        self.contents = contents
        currentIndex = items.isEmpty ? nil : 0
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(items.indices, id: \.self) { index in
                        SheetButton(index: index, selection: $currentIndex, item: items[index])
                        Divider()
                    }
                    Spacer()
                }
                .padding(0)
            }
            .frame(height: 30)
            Divider()
            if let index = currentIndex {
                contents(index)
                    .id(index)
            } else {
                Color(.clear)
            }
        }
        .layoutPriority(1)
    }
}

protocol SheetElement {
    var title: String { get }
    var icon: String? { get }
}
struct SheetButton: View {
    
    private var isSelected: Bool {
        selection.wrappedValue == index
    }
    let index: Int
    let selection: Binding<Int?>
    let item: SheetElement
    var body: some View {
        HStack(spacing: 4) {
            if let icon = item.icon {
                Image(systemName: icon)
            }
            Text(item.title)
                
                .lineLimit(1)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 20)
        .background(isSelected ? Color(.gray).opacity(0.5) : nil)
        .frame(maxWidth: .infinity)
        .onTapGesture {
            if selection.wrappedValue != index {
                selection.wrappedValue = index
            }
        }
    }
}
