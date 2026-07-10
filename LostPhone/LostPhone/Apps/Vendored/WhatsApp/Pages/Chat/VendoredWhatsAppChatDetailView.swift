//
//  VendoredWhatsAppChatDetailView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 9/4/24.
//

import SwiftUI

struct VendoredWhatsAppChatDetailView: View {
    @Environment(\.dismiss) var dismiss
    var chatResponse: VendoredWhatsAppChatResponse
    @State private var messages: [VendoredWhatsAppChatConversationResponse]
    @State private var sendMessageText = ""

    init(chatResponse: VendoredWhatsAppChatResponse) {
        self.chatResponse = chatResponse
        _messages = State(initialValue: chatConversationData)
    }

    private var lastMessageId: String? { messages.last?.id.uuidString }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Image("chat_background")
                    .resizable()
                    .edgesIgnoringSafeArea(.bottom)

                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            VendoredWhatsAppheaderSettingView()
                            ForEach(messages) { response in
                                VendoredWhatsAppBubbleChatView(
                                    text: response.text,
                                    isMe: response.isMe,
                                    timeAgo: response.dateTime,
                                    isReaction: response.isReaction ?? nil
                                )
                                .id(response.id.uuidString)
                            }
                        }
                        .padding()
                        .padding(.bottom, 90)
                    }
                    .onAppear {
                        scrollToBottom(proxy: proxy, animated: false)
                    }
                    .onChange(of: messages.count) { _, _ in
                        scrollToBottom(proxy: proxy, animated: true)
                    }
                }

                HStack(spacing: 20) {
                    Button {} label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                    }
                    HStack(spacing: 0) {
                        TextField("Message", text: $sendMessageText)
                            .padding(.all, 4)
                            .foregroundStyle(.primary)
                        Button { sendMessage() } label: {
                            Image(systemName: "paperplane.fill")
                                .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                        }
                    }
                    .padding(.horizontal, 12)
                    .background(Color(uiColor: .systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(.gray.opacity(0.3)))
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color(uiColor: .systemBackground))
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(uiColor: .systemBackground), for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Button { dismiss() } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                        }

                        HStack(spacing: 10) {
                            VendoredWhatsAppProfileImageView(profileImage: chatResponse.user.profileUrl, size: 40)
                            Text(chatResponse.user.name)
                                .font(.headline)
                                .foregroundStyle(.primary)
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 20) {
                        Image(systemName: "video")
                        Image(systemName: "phone")
                    }
                    .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                }
            }
        }
        .preferredColorScheme(.light)
    }

    private func sendMessage() {
        let text = sendMessageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        messages.append(
            VendoredWhatsAppChatConversationResponse(
                id: UUID(),
                text: text,
                isMe: true,
                isReaction: nil,
                dateTime: "Now"
            )
        )
        sendMessageText = ""
    }

    private func scrollToBottom(proxy: ScrollViewProxy, animated: Bool) {
        guard let id = lastMessageId else { return }
        if animated {
            withAnimation { proxy.scrollTo(id, anchor: .bottom) }
        } else {
            proxy.scrollTo(id, anchor: .bottom)
        }
    }
}

#Preview {
    VendoredWhatsAppChatDetailView(chatResponse: vendoredWhatsAppChatData[0])
}

struct VendoredWhatsAppheaderSettingView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Today")
                .font(.footnote)
                .padding(.vertical, 2)
                .padding(.horizontal)
                .background(Color.vendoredWhatsAppTodayChatBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.primary)

            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "lock.fill")
                    .frame(width: 8, height: 8)
                    .padding(.top, 6)
                Text("Messages and calls are end-to-end encrypted. No one outside of this chat, not even WhatsApp, can read or listen to them.")
                    .font(.footnote)
                    .foregroundStyle(.primary)
            }
            .padding(.vertical, 4)
            .padding(.horizontal)
            .background(Color.vendoredWhatsAppSettingChatBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 30)
        }
    }
}
