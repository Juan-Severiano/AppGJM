//
//  Filter.swift
//  AppGJM
//
//  Created by Francisco Juan on 26/03/25.
//


import SwiftUI

enum Selection<SelectionValue: Hashable> {
    case single(Binding<SelectionValue>)
    case multi(Binding<Set<SelectionValue>>)
}

struct Filter<Content: View, SelectionValue: Hashable>: View {
    
    private let selection: Selection<SelectionValue>
    
    let content: Content
    
    @_disfavoredOverload
    init(selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) {
        self.selection = .single(selection)
        self.content = content()
    }
 
    init(selection: Binding<Set<SelectionValue>>, @ViewBuilder content: () -> Content) {
        self.selection = .multi(selection)
        self.content = content()
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    _VariadicView.Tree(_FilterLayout(selection: selection)) {
                        content
                    }
                }
                .toggleStyle(.button)
            }
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
        }
    }
}

extension _VariadicView.Children.Element {

    var traits: [Any] {
        Mirror(reflecting: self).descendant("traits", "storage") as? [Any] ?? []
    }

    func tag<Value: Hashable>(as : Value.Type) -> Value? {
        for trait in self.traits {
            if Value.self is ExpressibleByNilLiteral.Type {
                if let tag = Mirror(reflecting: trait).descendant("value", "some", "tagged", "some") as? Value {
                    return tag
                }
            } else {
                if let tag = Mirror(reflecting: trait).descendant("value", "tagged") as? Value {
                    return tag
                }
                if let tag = Mirror(reflecting: trait).descendant("value", "some", "tagged") as? Value {
                    return tag
                }
            }
        }
        return nil
    }

}

fileprivate struct _FilterLayout<SelectionValue: Hashable>: _VariadicView_MultiViewRoot {
        
    let selection: Selection<SelectionValue>

    @ViewBuilder
    func body(children: _VariadicView.Children) -> some View {
        ForEach(children) { child in
            let tag = child.tag(as: SelectionValue.self)
            let isOn: Binding<Bool> = .init(
                get: { isSelected(tag) },
                set: { _ in action(tag) }
            )
            Button {
                isOn.wrappedValue.toggle()
            } label: {
                child
            }
        }
    }
    
    private func isSelected(_ tag: SelectionValue?) -> Bool {
        switch selection {
            case .single(let binding):
                return binding.wrappedValue == tag
            case .multi(let binding):
                if let tag {
                    return binding.wrappedValue.contains(tag)
                } else {
                    return false
                }
        }
    }
    
    private func action(_ tag: SelectionValue?) {
        if let tag {
            switch selection {
                case .single(let binding):
                    binding.wrappedValue = tag
                case .multi(let binding):
                    if binding.wrappedValue.contains(tag) {
                        binding.wrappedValue.remove(tag)
                    } else {
                        binding.wrappedValue.insert(tag)
                    }
            }
        }
    }
    
}


#Preview {
    
    @Previewable @State var selection: Set<String> = ["segunda-feira"]
    
    Filter(selection: $selection) {
        ForEach(["segunda-feira"], id: \.self) { value in
            let first = value.first!
            Text(String(first))
                .padding(4)
                .background {
                    if selection.contains(value) {
                        Circle()
                            .fill(.red)
                    }
                }
        }
    }
    
}
