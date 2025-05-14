import Foundation
import PlaySDK
import SwiftUI
import UIKit

/// Nested namespacing for ease of use when importing into your app
public enum MyChatApp { }

// MARK: Global Runtime Engine
// Using optional value since initialization might fail
public var RuntimeEngine: PlayRuntimeEngine? = nil

// Initialize the RuntimeEngine
public func setupRuntimeEngine() {
    // Try multiple possible factory method names and parameter combinations
    // based on the error messages we've been getting
    
    func attempt1() -> PlayRuntimeEngine? {
        do {
            return try PlaySDK.PlayRuntimeEngine.loadProjectJSON(
                bundle: Bundle.module,
                resource: "project", 
                ext: "json"
            )
        } catch {
            print("Method 1 failed: \(error)")
            return nil
        }
    }
    
    func attempt2() -> PlayRuntimeEngine? {
        do {
            return try PlaySDK.PlayRuntimeEngine.loadingProjectJSON(
                bundle: Bundle.module,
                resource: "project", 
                ext: "json"
            )
        } catch {
            print("Method 2 failed: \(error)")
            return nil
        }
    }
    
    func attempt3() -> PlayRuntimeEngine? {
        do {
            // Try with a shorter method name and different parameter order
            return try PlaySDK.PlayRuntimeEngine.load(
                resource: "project", 
                ext: "json",
                bundle: Bundle.module
            )
        } catch {
            print("Method 3 failed: \(error)")
            return nil
        }
    }
    
    func attempt4() -> PlayRuntimeEngine? {
        do {
            // Try with the method name in lower case
            return try PlaySDK.PlayRuntimeEngine.loadprojectjson(
                bundle: Bundle.module,
                resource: "project", 
                ext: "json"
            )
        } catch {
            print("Method 4 failed: \(error)")
            return nil
        }
    }
    
    func attempt5() -> PlayRuntimeEngine? {
        // Try accessing a static property if it exists
        if let engine = PlaySDK.PlayRuntimeEngine.defaultEngine {
            do {
                try engine.loadProject(
                    bundle: Bundle.module,
                    resource: "project", 
                    ext: "json"
                )
                return engine
            } catch {
                print("Method 5 failed: \(error)")
                return nil
            }
        }
        print("Method 5 failed: No defaultEngine available")
        return nil
    }
    
    // Try all methods in sequence
    RuntimeEngine = attempt1() ?? attempt2() ?? attempt3() ?? attempt4() ?? attempt5()
    
    if RuntimeEngine == nil {
        print("All attempts to initialize PlayRuntimeEngine failed")
    }
}

// Call setupRuntimeEngine immediately
public let _ = { setupRuntimeEngine() }()

typealias _State = SwiftUI.State

// MARK: Name spacing for each foundation
public enum Pages {
    public enum UIKit { }
    public enum SwiftUI { }
}
public enum Components {
    public enum UIKit { }
    public enum SwiftUI { }
}
public enum Colors {
    public enum UIKit { }
    public enum SwiftUI { }
}
public enum Gradients {
    public enum UIKit { }
    public enum SwiftUI { }
}
public enum Spacing { }
public enum Typography { }
public enum Radius { }

public enum Images { }
public enum Videos { }
public enum Audio { }
public enum Rive { }
public enum Json { }
public enum Ahap { }

public enum TypeAliases {
    public typealias _Pages = Pages
    public typealias _Components = Components
    public typealias _Colors = Colors
    public typealias _Gradients = Gradients
}

public enum UIK {
    public typealias Pages = TypeAliases._Pages.UIKit
    public typealias Components = TypeAliases._Components.UIKit
    public typealias Colors = TypeAliases._Colors.UIKit
    public typealias Gradients = TypeAliases._Gradients.UIKit
}

public enum SUI {
    public typealias Pages = TypeAliases._Pages.SwiftUI
    public typealias Components = TypeAliases._Components.SwiftUI
    public typealias Colors = TypeAliases._Colors.SwiftUI
    public typealias Gradients = TypeAliases._Gradients.SwiftUI
}

// SwiftUI aliases
extension View {
    public typealias MyChatApp = SUI
    public typealias Pages = TypeAliases._Pages.SwiftUI
    public typealias Components = TypeAliases._Components.SwiftUI
    public typealias Colors = SUI.Colors
    public typealias Gradients = SUI.Gradients
}

// UIKit aliases
extension UIResponder {
    public typealias MyChatApp = UIK
    public typealias Pages = TypeAliases._Pages.UIKit
    public typealias Components = TypeAliases._Components.UIKit
    public typealias Colors = TypeAliases._Colors.UIKit
    public typealias Gradients = TypeAliases._Gradients.UIKit
}
