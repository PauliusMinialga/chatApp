import Foundation
import PlaySDK
import SwiftUI
import UIKit

extension UIK.Pages {
    public class Main: UIKitBaseViewController<Main.AvailProps, Main> {
        override public var variables: AvailProps? { _variables }
        private var _variables: AvailProps = .init()

        override public var keyPathToPlayId: [AnyHashable: String] {
            get { _keyPathToPlayId }
            set { _keyPathToPlayId = newValue }
        }
        private var _keyPathToPlayId: [AnyHashable: String] = [:]

        public convenience init() {
            self.init(nibName: nil, bundle: nil)
        }

        public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nil, bundle: nil)
            if let RuntimeEngine {
                initialize(engine: RuntimeEngine, playId: "3e12c77e4dd2b23xkBn")
            }
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    @discardableResult public func setText(_ element: TextElement, value: String?) -> Self {
        Self.setText(view: self, elementId: element.playId, value: value)
        return self
    }

    }
}

extension UIK.Pages.Main {
    public struct AvailProps { 
        public init() { }
    }

    public enum TextElement {
        case text1

        var playId: String {
            switch self {
            case .text1:
                return "3e12ca49df9210VTWFV"
            }
        }
    }

}

extension SUI.Pages {
    public struct Main: SwiftUIBaseViewController {
        public typealias UIViewControllerType = UIK.Pages.Main
        public typealias ClassType = Self

        public var variables: UIK.Pages.Main.AvailProps? = .init()
        public var keyPathToPlayId: [AnyHashable: String] = [:]
        public var playIdToUpdateCall: [String : (Any?) -> Void] = [:]
        private var textToSet: [UIViewControllerType.TextElement: String?] = [:]


        public init() { }

        public func makeUIViewController(context: Context) -> UIViewControllerType {
            return UIViewControllerType()
        }

        public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            Self.updateUIViewController(uiViewController, suiController: self) { 
        textToSet.forEach { id, val in
        uiViewController.setText(id, value: val)
    }

            }
        }
        @discardableResult public func setText(_ element: UIViewControllerType.TextElement, value: String?) -> Self {
            var mutself = self
            mutself.textToSet[element] = value
            return mutself
        }

    }
}
