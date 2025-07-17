import SwiftUI
import Sentry

@main
struct SentryECommerceSampleApp: App {
    init() {
        SentrySDK.start { options in
            let env = ProcessInfo.processInfo.environment
            options.dsn = env["SENTRY_DSN"] ?? "<INSERT_DSN_HERE>"
            options.tracesSampleRate = 1.0
            options.profilesSampleRate = 1.0
            options.enableAutoSessionTracking = true
            options.enableSwizzling = true
            options.attachScreenshot = true
            options.attachViewHierarchy = true
            options.recordingSampleRate = 1.0
        }
    }
    
    @StateObject private var cartManager = CartManager()
    
    var body: some Scene {
        WindowGroup {
            CatalogView()
                .environmentObject(cartManager)
        }
    }
}
