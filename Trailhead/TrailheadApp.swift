import SwiftUI

@main
struct TrailheadApp: App {
    @State private var store = TrailStore()
    @State private var maps = OfflineMaps()

    var body: some Scene {
        WindowGroup {
            TrailList()
                .environment(store)
                .environment(maps)
                .task { await store.reload() }
        }
    }
}
