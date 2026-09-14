import SwiftUI

@main
struct TrailheadApp: App {
    @State private var store = TrailStore()

    var body: some Scene {
        WindowGroup {
            TrailList()
                .environment(store)
                .task { await store.reload() }
        }
    }
}
