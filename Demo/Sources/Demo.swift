import SwiftUI
import Combine
import CodeEditor

@main
struct DemoApp: App {
    let items = ["Test file 1", "Another test", "and yet again"].map { Editor.init($0)}

    var body: some SwiftUI.Scene {
        WindowGroup() {
            TabView {
                SheetView(items: items) { index in
                    TextEditor(text: items[index].binding)
                        .font(.body.monospaced())
                }
                .tabItem { Text("TextEditor") }
                SheetView(items: items) { index in
                    CodeEditor(source: items[index].binding,
                               language: .swift)
                    
                   
                } .tabItem { Text("CodeEditor") }
            }
        }
    }
}

class Editor: ObservableObject, SheetElement {
    let title: String
    var icon: String? { "swift" }
    var text: String
    lazy var binding: Binding<String> = .init(get: {[weak self] in self?.text ?? ""},
                                               set: {[weak self] in self?.text = $0})
    init(_ text: String) {
        self.title = text
        self.text = text
    }
}
