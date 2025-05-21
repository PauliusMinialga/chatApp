import Foundation
import PlaySDK
import SwiftUI
import UIKit
import ClerkSDK

extension UIK.Pages {
    public class Welcome: UIKitBaseViewController<Welcome.AvailProps, Welcome> {
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
                initialize(engine: RuntimeEngine, playId: "yKca5")
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

extension UIK.Pages.Welcome {
    public struct AvailProps { 
        public init() { }
    }

    public enum TextElement {
        case text1
        case text1_1

        var playId: String {
            switch self {
            case .text1:
                return "3e12c8693c0714j8WWJ"
            case .text1_1:
                return "3e12c88b5863b8hXVl8"
            }
        }
    }
}

extension SUI.Pages {
    public struct Welcome: View {
        @State private var isShowingChatList = false
        @State private var showSignInError = false
        
        public init() { }
        
        public var body: some View {
            NavigationView {
                ZStack {
                    // Background
                    Colors.SwiftUI.backgroundColor.ignoresSafeArea()
                    
                    // Content
                    VStack(spacing: 32) {
                        Spacer()
                            .frame(height: 20)
                        
                        // App Logo
                        VStack(spacing: 16) {
                            Image(systemName: "bubble.left.and.bubble.right.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .foregroundColor(Colors.SwiftUI.primaryBlue)
                            
                            Text("Chat App")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(Colors.SwiftUI.primaryText)
                        }
                        .padding(.bottom, 40)
                        
                        // Sign in button
                        VStack(spacing: 16) {
                            Button(action: {
                                Clerk.shared.presentSignIn { success in
                                    if success {
                                        isShowingChatList = true
                                    } else {
                                        showSignInError = true
                                    }
                                }
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Sign in with Clerk")
                                        .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(Colors.SwiftUI.invertedText)
                                    Spacer()
                                }
                                .frame(height: 52)
                                  .background(Colors.SwiftUI.primaryBlue)
                                .cornerRadius(12)
                            }
                            .padding(.horizontal, 24)
                            
                            // Continue as guest button
                            Button(action: {
                                // No authentication, proceed as guest
                                isShowingChatList = true
                            }) {
                                Text("Continue as Guest")
                                    .font(.system(size: 16))
                                    .foregroundColor(Colors.SwiftUI.primaryBlue)
                            }
                            .padding()
                            .frame(height: 44) // Apple's minimum touch target size
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .navigationBarHidden(true)
                }
                .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .fullScreenCover(isPresented: $isShowingChatList) {
                // Navigate to the chat list screen
                Pages.ChatList()
            }
            .alert("Sign in failed", isPresented: $showSignInError) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}
