import SwiftUI

/// Port SwiftUI du clone Flutter Sopheamen `grok_clone_v1` (`home_page.dart`).
struct VendoredGrokHomeView: View {
    @State private var prompt = ""
    @State private var isTyping = false
    @State private var question = ""
    @State private var displayedResponse = ""
    @FocusState private var focused: Bool

    var body: some View {
        VStack(spacing: 0) {
            grokAppBar
            if isTyping {
                chatBody
            } else {
                categoriesBody
            }
            footerInput
        }
        .background(VendoredGrokTheme.background.ignoresSafeArea())
    }

    private var grokAppBar: some View {
        HStack {
            Image(systemName: "line.3.horizontal")
                .font(.system(size: 18, weight: .semibold))
            Spacer()
            HStack(spacing: 6) {
                Circle()
                    .fill(VendoredGrokTheme.redIndicator)
                    .frame(width: 10, height: 10)
                Text("Grok 3")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(VendoredGrokTheme.textPrimary)
                Image(systemName: "chevron.down")
                    .font(.system(size: 14, weight: .semibold))
            }
            Spacer()
            Image(systemName: "square.and.pencil")
                .font(.system(size: 18, weight: .semibold))
        }
        .foregroundStyle(VendoredGrokTheme.textPrimary)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private var categoriesBody: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(VendoredGrokData.categories) { item in
                    VStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(VendoredGrokTheme.card)
                            .frame(width: 70, height: 70)
                            .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
                            .overlay {
                                Text(item.icon)
                                    .font(.system(size: 26))
                            }
                        Text(item.title)
                            .font(.system(size: 12))
                            .foregroundStyle(VendoredGrokTheme.textPrimary)
                            .multilineTextAlignment(.center)
                            .frame(width: 70)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }

    private var chatBody: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(question)
                    .font(.system(size: 16))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(VendoredGrokTheme.card, in: RoundedRectangle(cornerRadius: 24, style: .continuous))

                Text(displayedResponse)
                    .font(.system(size: 15))
                    .foregroundStyle(VendoredGrokTheme.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
        }
    }

    private var footerInput: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField("Ask Anything", text: $prompt, axis: .vertical)
                .font(.system(size: 14))
                .foregroundStyle(VendoredGrokTheme.textPrimary)
                .focused($focused)
                .onSubmit { submitPrompt() }

            HStack(spacing: 4) {
                Button {
                    prompt += prompt.isEmpty ? "[Pièce jointe]" : " [Pièce jointe]"
                } label: {
                    Image(systemName: "paperclip")
                        .font(.system(size: 18))
                        .foregroundStyle(VendoredGrokTheme.textPrimary)
                }
                footerChip("DeepSearch")
                footerChip("Think")
                Spacer()
                Button {
                    submitPrompt()
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(
                            prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                ? VendoredGrokTheme.textPrimary.opacity(0.3)
                                : VendoredGrokTheme.textPrimary
                        )
                }
                .disabled(prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                Button {} label: {
                    Image(systemName: "mic")
                        .font(.system(size: 18))
                }
            }
            .foregroundStyle(VendoredGrokTheme.textPrimary)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(VendoredGrokTheme.card)
                .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 30)
        .padding(.top, 8)
    }

    private func footerChip(_ label: String) -> some View {
        Text(label)
            .font(.system(size: 12))
            .foregroundStyle(VendoredGrokTheme.textPrimary)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .overlay {
                Capsule().stroke(VendoredGrokTheme.border, lineWidth: 1)
            }
    }

    private func submitPrompt() {
        let trimmed = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        question = trimmed
        prompt = ""
        isTyping = true
        displayedResponse = ""
        Task {
            for char in VendoredGrokData.sampleResponse {
                try? await Task.sleep(nanoseconds: 20_000_000)
                await MainActor.run {
                    displayedResponse.append(char)
                }
            }
        }
    }
}
