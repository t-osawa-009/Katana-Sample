import UIKit
import Katana
import KatanaMonitor


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var renderer: Renderer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UIViewController()
        self.window?.rootViewController?.view.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        counterDemo()
        return true
    }

    
    private func counterDemo() {
        let view = (self.window?.rootViewController?.view)!
        let rootBounds = UIScreen.main.bounds
        var middleware: [StoreMiddleware] = [
            // other middleware
        ]
        #if DEBUG
        middleware.append(MonitorMiddleware.create(using: .defaultConfiguration))
        #endif
        
        let store = Store<CounterState>.init(middleware: middleware, dependencies: EmptySideEffectDependencyContainer.self)
        let counterScreen = CounterScreen(props: CounterScreen.Props.build({ (counterScreenProps) in
            counterScreenProps.frame = rootBounds
        }))
        
        renderer = Renderer(rootDescription: counterScreen, store: store)
        renderer!.render(in: view)
    }
}

