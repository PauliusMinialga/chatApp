import Foundation
import SwiftUI

// MARK: - Data Models for UI
struct ChatPreview: Identifiable {
    let id: String
    let name: String
    let lastMessage: String
    let timeString: String
    let avatarURL: URL?
    
    var initials: String {
        let components = name.components(separatedBy: " ")
        if components.count > 1, 
           let first = components.first?.first,
           let last = components.last?.first {
            return "\(first)\(last)"
        } else if let first = name.first {
            return String(first)
        }
        return "?"
    }
}

extension SUI.Pages {
    public struct ChatList: View {
        // Use our shared design system colors
        @State private var searchText = ""
        @State private var showingNewChat = false
        @State private var showingProfile = false
        
        // Sample data
        private let chatPreviews = [
            ChatPreview(id: "1", name: "ChatGPT", lastMessage: "How can I help you today?", timeString: "9:41", avatarURL: nil),
            ChatPreview(id: "2", name: "Alex Johnson", lastMessage: "Working on the project now", timeString: "Tues", avatarURL: nil),
            ChatPreview(id: "3", name: "Sarah Miller", lastMessage: "Let's meet for coffee soon", timeString: "Mon", avatarURL: nil)
        ]
        
        public init() { }
        
        public var body: some View {
            NavigationView {
                ZStack {
                    // Background
                    Colors.SwiftUI.backgroundColor.ignoresSafeArea()
                    
                    // Main content
                    VStack(spacing: 0) {
                        // Search bar
                        searchBar
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        
                        // Chat list
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(chatPreviews) { chat in
                                    ChatListRow(chat: chat)
                                    
                                    if chat.id != chatPreviews.last?.id {
                                        Divider()
                                            .padding(.leading, 80)
                                    }
                                }
                            }
                        }
                        
                        Spacer(minLength: 0)
                    }
                    
                    // New chat button
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                showingNewChat = true
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(Colors.SwiftUI.invertedText)
                                    .frame(width: 56, height: 56)
                                    .background(Colors.SwiftUI.primaryBlue)
                                    .clipShape(Circle())
                                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                            }
                            .padding(.trailing, 24)
                            .padding(.bottom, 24)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Chats")
                            .font(.system(size: 17, weight: .semibold))
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingProfile = true
                        }) {
                            Image(systemName: "person.circle")
                                .font(.system(size: 22))
                                .foregroundColor(Colors.SwiftUI.primaryBlue)
                                .frame(width: 44, height: 44)
                        }
                    }
                }
            }
            .sheet(isPresented: $showingNewChat) {
                // This would be the new chat screen
                NewChatPlaceholder()
            }
            .sheet(isPresented: $showingProfile) {
                // This would be the profile screen
                ProfilePlaceholder()
            }
        }
        
        // Search bar component
        private var searchBar: some View {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                
                TextField("Search chats", text: $searchText)
                    .font(.system(size: 15))
                    .padding(10)
                    .frame(height: 36)
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                            .frame(width: 44, height: 44)
                    }
                }
            }
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
    
    // Chat list row component
    private struct ChatListRow: View {
        let chat: ChatPreview
        
        var body: some View {
            HStack(spacing: 12) {
                // Avatar
                ZStack {
                    if let url = chat.avatarURL {
                        AsyncImage(url: url) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } else {
                                InitialsView(initials: chat.initials)
                            }
                        }
                    } else {
                        InitialsView(initials: chat.initials)
                    }
                }
                .frame(width: 52, height: 52)
                .clipShape(Circle())
                
                // Chat info
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(chat.name)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(Colors.SwiftUI.primaryText)
                        
                        Spacer()
                        
                        Text(chat.timeString)
                            .font(.system(size: 13))
                            .foregroundColor(Colors.SwiftUI.secondaryText)
                    }
                    
                    Text(chat.lastMessage)
                        .font(.system(size: 14))
                        .foregroundColor(Colors.SwiftUI.secondaryText)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(height: 76)
            .contentShape(Rectangle())
        }
    }
    
    // Initials view for avatar placeholder
    private struct InitialsView: View {
        let initials: String
        
        var body: some View {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                Text(initials)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Colors.SwiftUI.invertedText)
            }
        }
    }
    
    // Placeholder screens
    private struct NewChatPlaceholder: View {
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            NavigationView {
                VStack {
                    Text("New Chat Screen")
                        .font(.title)
                        .padding()
                    
                    Text("This is where you would select a contact or start a new conversation.")
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button("Dismiss") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .background(Colors.SwiftUI.primaryBlue)
                    .foregroundColor(Colors.SwiftUI.invertedText)
                    .cornerRadius(12)
                }
                .navigationTitle("New Chat")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
    
    private struct ProfilePlaceholder: View {
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            NavigationView {
                VStack {
                    Text("Profile Screen")
                        .font(.title)
                        .padding()
                    
                    Text("This is where you would see and edit your profile.")
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button("Dismiss") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .background(Colors.SwiftUI.primaryBlue)
                    .foregroundColor(Colors.SwiftUI.invertedText)
                    .cornerRadius(12)
                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Done") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
} 