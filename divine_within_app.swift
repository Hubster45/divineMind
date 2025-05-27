import SwiftUI
import AVFoundation
import UserNotifications
import Combine

// MARK: - Main App
@main
struct DivineWithinApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onAppear {
                    requestNotificationPermission()
                }
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }
}

// MARK: - App State
class AppState: ObservableObject {
    @Published var selectedTab = 0
    @Published var meditationSessions: [MeditationSession] = []
    @Published var dailyAffirmation: DailyAffirmation?
    @Published var communityPosts: [CommunityPost] = []
    @Published var weeklyEvents: [WeeklyEvent] = []
    @Published var breathworkSessions: [BreathworkSession] = []
    
    init() {
        loadSampleData()
    }
    
    private func loadSampleData() {
        // Sample affirmations
        let affirmations = [
            "I am divine consciousness expressing itself through this human form.",
            "My true nature is infinite love and boundless awareness.",
            "I remember my unity with all existence in this sacred moment.",
            "Divine light flows through me, healing and transforming everything.",
            "I am whole, perfect, and complete exactly as I am right now.",
            "Love is my essence, and I radiate it freely to all beings.",
            "I trust the divine wisdom that flows through every breath.",
            "My heart is open to receive and give infinite compassion."
        ]
        
        dailyAffirmation = DailyAffirmation(
            text: affirmations.randomElement() ?? affirmations[0],
            date: Date()
        )
        
        // Sample community posts
        communityPosts = [
            CommunityPost(
                author: "Divine Teacher",
                title: "The Illusion of Separation",
                content: "When we truly understand that all is one consciousness expressing itself through infinite forms, suffering dissolves into compassion, fear transforms into love, and we recognize every being as another face of our own divine nature.",
                timestamp: Date().addingTimeInterval(-3600),
                type: .teaching
            ),
            CommunityPost(
                author: "Sacred Circle",
                title: "Community Reflection",
                content: "Today I experienced a profound moment of remembering during meditation. The boundary between 'me' and 'everything else' simply wasn't there. We are all waves in the same infinite ocean of consciousness.",
                timestamp: Date().addingTimeInterval(-7200),
                type: .reflection
            ),
            CommunityPost(
                author: "Light Bearer",
                title: "Divine Wisdom",
                content: "Healing is not about fixing what's broken - it's about remembering what was never damaged. Your divine essence is eternally perfect, whole, and complete.",
                timestamp: Date().addingTimeInterval(-10800),
                type: .wisdom
            ),
            CommunityPost(
                author: "Breath Master",
                title: "The Sacred Breath",
                content: "Each breath is a gift from the universe. In the space between inhale and exhale, we find the eternal present moment where all transformation becomes possible.",
                timestamp: Date().addingTimeInterval(-14400),
                type: .teaching
            )
        ]
        
        // Sample weekly events
        weeklyEvents = [
            WeeklyEvent(
                title: "Divine Unity Meditation",
                description: "Group meditation focusing on our interconnectedness and shared divine nature",
                date: Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date(),
                duration: 45,
                type: .meditation
            ),
            WeeklyEvent(
                title: "Sacred Teaching Circle",
                description: "Exploring the nature of consciousness and divine identity through ancient wisdom",
                date: Calendar.current.date(byAdding: .day, value: 4, to: Date()) ?? Date(),
                duration: 60,
                type: .teaching
            ),
            WeeklyEvent(
                title: "Healing Light Gathering",
                description: "Collective healing through divine love transmission and energy work",
                date: Calendar.current.date(byAdding: .day, value: 6, to: Date()) ?? Date(),
                duration: 90,
                type: .healing
            ),
            WeeklyEvent(
                title: "Breathwork Journey",
                description: "Transformative breathing techniques for spiritual awakening",
                date: Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date(),
                duration: 75,
                type: .breathwork
            )
        ]
    }
    
    func addMeditationSession(_ session: MeditationSession) {
        meditationSessions.append(session)
    }
    
    func addBreathworkSession(_ session: BreathworkSession) {
        breathworkSessions.append(session)
    }
}

// MARK: - Data Models
struct MeditationSession {
    let id = UUID()
    let duration: TimeInterval
    let date: Date
    let type: MeditationType
    let completed: Bool
}

enum MeditationType: String, CaseIterable {
    case divine = "Divine Connection"
    case breath = "Sacred Breath"
    case unity = "Unity Awareness"
    case healing = "Divine Healing"
    case lovingKindness = "Loving Kindness"
}

struct BreathworkSession {
    let id = UUID()
    let technique: BreathworkTechnique
    let duration: TimeInterval
    let date: Date
    let completed: Bool
}

enum BreathworkTechnique: String, CaseIterable {
    case box = "Box Breathing"
    case wim = "Wim Hof Method"
    case coherent = "Heart Coherence"
    case alternate = "Alternate Nostril"
    case fire = "Breath of Fire"
    
    var description: String {
        switch self {
        case .box: return "4-4-4-4 pattern for calm focus"
        case .wim: return "Energizing cold exposure preparation"
        case .coherent: return "5-5 pattern for heart-brain harmony"
        case .alternate: return "Balancing left and right brain hemispheres"
        case .fire: return "Rapid breathing for energy activation"
        }
    }
    
    var color: Color {
        switch self {
        case .box: return .blue
        case .wim: return .orange
        case .coherent: return .green
        case .alternate: return .purple
        case .fire: return .red
        }
    }
}

struct DailyAffirmation {
    let text: String
    let date: Date
}

struct CommunityPost {
    let id = UUID()
    let author: String
    let title: String
    let content: String
    let timestamp: Date
    let type: PostType
}

enum PostType {
    case teaching, reflection, wisdom
    
    var color: Color {
        switch self {
        case .teaching: return .blue
        case .reflection: return .green
        case .wisdom: return .purple
        }
    }
    
    var icon: String {
        switch self {
        case .teaching: return "book.circle.fill"
        case .reflection: return "heart.circle.fill"
        case .wisdom: return "star.circle.fill"
        }
    }
}

struct WeeklyEvent {
    let id = UUID()
    let title: String
    let description: String
    let date: Date
    let duration: Int // minutes
    let type: EventType
}

enum EventType {
    case meditation, teaching, healing, breathwork
    
    var color: Color {
        switch self {
        case .meditation: return .indigo
        case .teaching: return .orange
        case .healing: return .pink
        case .breathwork: return .cyan
        }
    }
    
    var icon: String {
        switch self {
        case .meditation: return "figure.mind.and.body"
        case .teaching: return "graduationcap.fill"
        case .healing: return "heart.text.square.fill"
        case .breathwork: return "wind"
        }
    }
}

// MARK: - Main Content View
struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView(selection: $appState.selectedTab) {
            MeditationView()
                .tabItem {
                    Image(systemName: "figure.mind.and.body")
                    Text("Meditate")
                }
                .tag(0)
            
            AffirmationView()
                .tabItem {
                    Image(systemName: "heart.text.square.fill")
                    Text("Affirmations")
                }
                .tag(1)
            
            CommunityView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Community")
                }
                .tag(2)
            
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Events")
                }
                .tag(3)
            
            BreathworkView()
                .tabItem {
                    Image(systemName: "wind")
                    Text("Breathwork")
                }
                .tag(4)
        }
        .accentColor(.purple)
    }
}

// MARK: - Meditation View
struct MeditationView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedDuration: TimeInterval = 600 // 10 minutes
    @State private var selectedType: MeditationType = .divine
    @State private var showingTimer = false
    
    private let durations: [TimeInterval] = [300, 600, 900, 1200, 1800] // 5, 10, 15, 20, 30 minutes
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [Color.purple.opacity(0.3), Color.indigo.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Header
                        VStack(spacing: 10) {
                            Text("Sacred Meditation")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("Connect with your divine essence")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top)
                        
                        // Stats card
                        if !appState.meditationSessions.isEmpty {
                            VStack(spacing: 10) {
                                HStack {
                                    VStack {
                                        Text("\(appState.meditationSessions.count)")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        Text("Sessions")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Text("\(Int(totalMeditationTime() / 60))")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        Text("Minutes")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Text("\(streakDays())")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        Text("Day Streak")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.8))
                                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                                )
                            }
                            .padding(.horizontal)
                        }
                        
                        // Meditation Type Selector
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Meditation Focus")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 15) {
                                ForEach(MeditationType.allCases, id: \.self) { type in
                                    MeditationTypeCard(
                                        type: type,
                                        isSelected: selectedType == type
                                    ) {
                                        selectedType = type
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        // Duration Selector
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Duration")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(durations, id: \.self) { duration in
                                        DurationButton(
                                            duration: duration,
                                            isSelected: selectedDuration == duration
                                        ) {
                                            selectedDuration = duration
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        // Start Button
                        Button(action: {
                            showingTimer = true
                        }) {
                            HStack {
                                Image(systemName: "play.circle.fill")
                                    .font(.title2)
                                Text("Begin Sacred Practice")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                LinearGradient(
                                    colors: [.purple, .indigo],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(28)
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 100)
                    }
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showingTimer) {
                MeditationTimerView(
                    duration: selectedDuration,
                    type: selectedType,
                    isPresented: $showingTimer
                )
                .environmentObject(appState)
            }
        }
    }
    
    private func totalMeditationTime() -> TimeInterval {
        appState.meditationSessions.reduce(0) { $0 + $1.duration }
    }
    
    private func streakDays() -> Int {
        // Simple streak calculation
        let calendar = Calendar.current
        let today = Date()
        var streak = 0
        var checkDate = today
        
        while streak < 365 { // Max check 1 year
            let dayStart = calendar.startOfDay(for: checkDate)
            let dayEnd = calendar.date(byAdding: .day, value: 1, to: dayStart)!
            
            let sessionsForDay = appState.meditationSessions.filter { session in
                session.date >= dayStart && session.date < dayEnd && session.completed
            }
            
            if sessionsForDay.isEmpty {
                break
            }
            
            streak += 1
            checkDate = calendar.date(byAdding: .day, value: -1, to: checkDate)!
        }
        
        return streak
    }
}

// MARK: - Meditation Type Card
struct MeditationTypeCard: View {
    let type: MeditationType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Image(systemName: iconForType(type))
                    .font(.title2)
                    .foregroundColor(isSelected ? .white : .purple)
                
                Text(type.rawValue)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.purple : Color.gray.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.purple.opacity(0.3), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func iconForType(_ type: MeditationType) -> String {
        switch type {
        case .divine: return "star.circle"
        case .breath: return "wind.circle"
        case .unity: return "infinity.circle"
        case .healing: return "heart.circle"
        case .lovingKindness: return "hands.sparkles"
        }
    }
}

// MARK: - Duration Button
struct DurationButton: View {
    let duration: TimeInterval
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 5) {
                Text("\(Int(duration / 60))")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("min")
                    .font(.caption)
            }
            .foregroundColor(isSelected ? .white : .purple)
            .frame(width: 60, height: 60)
            .background(
                Circle()
                    .fill(isSelected ? Color.purple : Color.gray.opacity(0.1))
            )
            .overlay(
                Circle()
                    .stroke(Color.purple.opacity(0.3), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Meditation Timer View
struct MeditationTimerView: View {
    let duration: TimeInterval
    let type: MeditationType
    @Binding var isPresented: Bool
    @EnvironmentObject var appState: AppState
    
    @State private var timeRemaining: TimeInterval
    @State private var timer: Timer?
    @State private var isActive = false
    @State private var audioPlayer: AVAudioPlayer?
    @State private var showingCompletion = false
    
    init(duration: TimeInterval, type: MeditationType, isPresented: Binding<Bool>) {
        self.duration = duration
        self.type = type
        self._isPresented = isPresented
        self._timeRemaining = State(initialValue: duration)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.black, Color.purple.opacity(0.8), Color.indigo.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if showingCompletion {
                CompletionView {
                    isPresented = false
                }
            } else {
                VStack(spacing: 40) {
                    // Close button
                    HStack {
                        Spacer()
                        Button("Close") {
                            stopTimer()
                            isPresented = false
                        }
                        .foregroundColor(.white)
                        .padding()
                    }
                    
                    Spacer()
                    
                    // Meditation type
                    Text(type.rawValue)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.8))
                    
                    // Timer circle
                    ZStack {
                        Circle()
                            .stroke(Color.white.opacity(0.2), lineWidth: 8)
                            .frame(width: 200, height: 200)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(1 - (timeRemaining / duration)))
                            .stroke(
                                LinearGradient(
                                    colors: [.purple, .indigo, .pink],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                style: StrokeStyle(lineWidth: 8, lineCap: .round)
                            )
                            .frame(width: 200, height: 200)
                            .rotationEffect(.degrees(-90))
                            .animation(.linear(duration: 1), value: timeRemaining)
                        
                        VStack(spacing: 8) {
                            Text(timeString(from: timeRemaining))
                                .font(.system(size: 36, weight: .light, design: .monospaced))
                                .foregroundColor(.white)
                            
                            Text("remaining")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }
                    
                    // Sacred message
                    Text(messageForType(type))
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    // Control buttons
                    HStack(spacing: 40) {
                        Button(action: {
                            if isActive {
                                pauseTimer()
                            } else {
                                startTimer()
                            }
                        }) {
                            Image(systemName: isActive ? "pause.circle.fill" : "play.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                        }
                        
                        Button(action: {
                            stopTimer()
                            isPresented = false
                        }) {
                            Image(systemName: "stop.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func startTimer() {
        isActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                completeSession()
            }
        }
    }
    
    private func pauseTimer() {
        isActive = false
        timer?.invalidate()
        timer = nil
    }
    
    private func stopTimer() {
        isActive = false
        timer?.invalidate()
        timer = nil
    }
    
    private func completeSession() {
        stopTimer()
        playGongSound()
        
        // Add completed session to app state
        let session = MeditationSession(
            duration: duration,
            date: Date(),
            type: type,
            completed: true
        )
        appState.addMeditationSession(session)
        
        withAnimation(.easeInOut(duration: 0.5)) {
            showingCompletion = true
        }
    }
    
    private func playGongSound() {
        // Create multiple system sounds for gong effect
        AudioServicesPlaySystemSound(1106) // Glass sound
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            AudioServicesPlaySystemSound(1107) // Horn sound
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            AudioServicesPlaySystemSound(1108) // Bell sound
        }
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func messageForType(_ type: MeditationType) -> String {
        switch type {
        case .divine:
            return "Breathe deeply and remember your divine nature. You are consciousness itself, experiencing life through this sacred form."
        case .breath:
            return "Focus on your breath, the bridge between body and spirit. Each breath connects you to the infinite source of life."
        case .unity:
            return "Feel your connection to all existence. The boundaries you perceive are illusions - all is one divine consciousness."
        case .healing:
            return "Allow divine love to flow through every cell of your being, healing and transforming all that needs attention."
        case .lovingKindness:
            return "Send love to yourself, your loved ones, and all beings everywhere. Love is the essence of your true nature."
        }
    }
}

// MARK: - Completion View
struct CompletionView: View {
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
            
            Text("Sacred Practice Complete")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("You have honored your divine nature through mindful presence. Carry this peace with you.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.8))
                .padding(.horizontal, 40)
            
            Button("Return to Light") {
                onDismiss()
            }
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 200, height: 50)
            .background(
                LinearGradient(
                    colors: [.purple, .indigo],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(25)
        }
    }
}

// MARK: - Affirmation View
struct AffirmationView: View {
    @EnvironmentObject var appState: AppState
    @State private var showingHistory = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [Color.pink.opacity(0.3), Color.orange.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Header
                        VStack(spacing: 10) {
                            Text("Divine Affirmations")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("Today's Sacred Truth")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top)
                        
                        // Today's affirmation card
                        if let affirmation = appState.dailyAffirmation {
                            VStack(spacing: 25) {
                                Text(affirmation.text)
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 20)
                                
                                Button("Share This Truth") {
                                    shareAffirmation(affirmation.text)
                                }
                                .foregroundColor(.white)
                                .frame(width: 160, height: 44)
                                .background(
                                    LinearGradient(
                                        colors: [.pink, .orange],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(22)
                            }
                            .padding(30)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.white.opacity(0.9))
                                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                            )
                            .padding(.horizontal)
                        }
                        
                        // Daily practices
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Sacred Practices")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 15) {
                                PracticeCard(
                                    title: "Morning Intention",
                                    description: "Set your divine intention for the day",
                                    icon: "sunrise.fill",
                                    color: .orange
                                )
                                
                                PracticeCard(
                                    title: "Midday Reminder",
                                    description: "Remember your true divine nature",
                                    icon: "sun.max.fill",
                                    color: .yellow
                                )
                                
                                PracticeCard(
                                    title: "Evening Gratitude",
                                    description: "Honor the sacred in your day",
                                    icon: "moon.stars.fill",
                                    color: .purple
                                )
                                
                                PracticeCard(
                                    title: "Night Blessing",
                                    description: "Send love to all beings",
                                    icon: "heart.fill",
                                    color: .pink
                                )
                            }
                            .padding(.horizontal)
                        }
                        
                        Spacer(minLength: 100)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private func shareAffirmation(_ text: String) {
        let activityVC = UIActivityViewController(
            activityItems: [text],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(activityVC, animated: true)
        }
    }
}

// MARK: - Practice Card
struct PracticeCard: View {
    let title: String
    let description: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(20)
        .frame(height: 120)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.8))
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
}

// MARK: - Community View
struct CommunityView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [Color.green.opacity(0.3), Color.blue.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        // Header
                        VStack(spacing: 10) {
                            Text("Sacred Community")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("Divine teachings and reflections")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top)
                        
                        // Community posts
                        ForEach(appState.communityPosts, id: \.id) { post in
                            CommunityPostCard(post: post)
                        }
                        
                        Spacer(minLength: 100)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Community Post Card
struct CommunityPostCard: View {
    let post: CommunityPost
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Header
            HStack {
                Image(systemName: post.type.icon)
                    .foregroundColor(post.type.color)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(post.author)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(timeAgoString(from: post.timestamp))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            // Title
            Text(post.title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            // Content
            Text(post.content)
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(nil)
            
            // Actions
            HStack(spacing: 20) {
                Button(action: {}) {
                    HStack(spacing: 5) {
                        Image(systemName: "heart")
                        Text("Resonate")
                    }
                    .font(.subheadline)
                    .foregroundColor(post.type.color)
                }
                
                Button(action: {}) {
                    HStack(spacing: 5) {
                        Image(systemName: "bubble.right")
                        Text("Reflect")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.9))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
    
    private func timeAgoString(from date: Date) -> String {
        let interval = Date().timeIntervalSince(date)
        let hours = Int(interval / 3600)
        if hours < 1 {
            return "Just now"
        } else if hours < 24 {
            return "\(hours)h ago"
        } else {
            let days = hours / 24
            return "\(days)d ago"
        }
    }
}

// MARK: - Calendar View
struct CalendarView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [Color.indigo.opacity(0.3), Color.purple.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        // Header
                        VStack(spacing: 10) {
                            Text("Sacred Calendar")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("Weekly divine gatherings")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top)
                        
                        // This week section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Upcoming Events")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                            
                            ForEach(appState.weeklyEvents, id: \.id) { event in
                                WeeklyEventCard(event: event)
                            }
                        }
                        
                        Spacer(minLength: 100)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Weekly Event Card
struct WeeklyEventCard: View {
    let event: WeeklyEvent
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: event.type.icon)
                    .foregroundColor(event.type.color)
                    .font(.title3)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(event.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text("\(event.duration) minutes")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text(dateFormatter.string(from: event.date))
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    
                    Text(timeFormatter.string(from: event.date))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Text(event.description)
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(2)
            
            Button("Join Sacred Circle") {
                scheduleNotification(for: event)
            }
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 36)
            .background(event.type.color)
            .cornerRadius(18)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.9))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }
    
    private func scheduleNotification(for event: WeeklyEvent) {
        let content = UNMutableNotificationContent()
        content.title = "Sacred Gathering"
        content.body = "\(event.title) begins in 15 minutes"
        content.sound = .default
        
        let triggerDate = Calendar.current.date(byAdding: .minute, value: -15, to: event.date)!
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate),
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: event.id.uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
}

// MARK: - Breathwork View
struct BreathworkView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTechnique: BreathworkTechnique = .box
    @State private var selectedDuration: TimeInterval = 300 // 5 minutes
    @State private var showingBreathTimer = false
    
    private let durations: [TimeInterval] = [180, 300, 600, 900] // 3, 5, 10, 15 minutes
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [Color.cyan.opacity(0.3), Color.blue.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Header
                        VStack(spacing: 10) {
                            Text("Sacred Breathwork")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("Transform through conscious breathing")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top)
                        
                        // Stats card
                        if !appState.breathworkSessions.isEmpty {
                            VStack(spacing: 10) {
                                HStack {
                                    VStack {
                                        Text("\(appState.breathworkSessions.count)")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        Text("Sessions")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Text("\(Int(totalBreathworkTime() / 60))")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        Text("Minutes")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Text("\(favoriteBreathwork())")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.5)
                                        Text("Favorite")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.8))
                                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                                )
                            }
                            .padding(.horizontal)
                        }
                        
                        // Technique Selector
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Breathing Technique")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 15) {
                                ForEach(BreathworkTechnique.allCases, id: \.self) { technique in
                                    BreathworkTechniqueCard(
                                        technique: technique,
                                        isSelected: selectedTechnique == technique
                                    ) {
                                        selectedTechnique = technique
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Duration Selector
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Duration")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(durations, id: \.self) { duration in
                                        DurationButton(
                                            duration: duration,
                                            isSelected: selectedDuration == duration
                                        ) {
                                            selectedDuration = duration
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        // Start Button
                        Button(action: {
                            showingBreathTimer = true
                        }) {
                            HStack {
                                Image(systemName: "wind")
                                    .font(.title2)
                                Text("Begin Breathwork")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                LinearGradient(
                                    colors: [.cyan, .blue],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(28)
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 100)
                    }
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showingBreathTimer) {
                BreathworkTimerView(
                    technique: selectedTechnique,
                    duration: selectedDuration,
                    isPresented: $showingBreathTimer
                )
                .environmentObject(appState)
            }
        }
    }
    
    private func totalBreathworkTime() -> TimeInterval {
        appState.breathworkSessions.reduce(0) { $0 + $1.duration }
    }
    
    private func favoriteBreathwork() -> String {
        let sessionsByTechnique = Dictionary(grouping: appState.breathworkSessions) { $0.technique }
        let mostUsed = sessionsByTechnique.max(by: { $0.value.count < $1.value.count })
        return mostUsed?.key.rawValue.components(separatedBy: " ").first ?? "None"
    }
}

// MARK: - Breathwork Technique Card
struct BreathworkTechniqueCard: View {
    let technique: BreathworkTechnique
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Circle()
                    .fill(technique.color)
                    .frame(width: 12, height: 12)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(technique.rawValue)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(technique.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(technique.color)
                        .font(.title2)
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? technique.color.opacity(0.1) : Color.white.opacity(0.8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isSelected ? technique.color : Color.gray.opacity(0.2), lineWidth: 2)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Breathwork Timer View
struct BreathworkTimerView: View {
    let technique: BreathworkTechnique
    let duration: TimeInterval
    @Binding var isPresented: Bool
    @EnvironmentObject var appState: AppState
    
    @State private var timeRemaining: TimeInterval
    @State private var timer: Timer?
    @State private var breathTimer: Timer?
    @State private var isActive = false
    @State private var currentPhase = BreathPhase.inhale
    @State private var phaseTimeRemaining: TimeInterval = 4
    @State private var cycleCount = 0
    @State private var showingCompletion = false
    
    init(technique: BreathworkTechnique, duration: TimeInterval, isPresented: Binding<Bool>) {
        self.technique = technique
        self.duration = duration
        self._isPresented = isPresented
        self._timeRemaining = State(initialValue: duration)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.black, technique.color.opacity(0.8), Color.blue.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if showingCompletion {
                BreathworkCompletionView {
                    isPresented = false
                }
            } else {
                VStack(spacing: 40) {
                    // Close button
                    HStack {
                        Spacer()
                        Button("Close") {
                            stopTimers()
                            isPresented = false
                        }
                        .foregroundColor(.white)
                        .padding()
                    }
                    
                    Spacer()
                    
                    // Technique name
                    Text(technique.rawValue)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.8))
                    
                    // Breathing visualization
                    ZStack {
                        // Outer circle (breathing indicator)
                        Circle()
                            .stroke(Color.white.opacity(0.2), lineWidth: 4)
                            .frame(width: 250, height: 250)
                        
                        // Inner circle (animated breathing)
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [technique.color.opacity(0.8), technique.color.opacity(0.3)],
                                    center: .center,
                                    startRadius: 20,
                                    endRadius: 100
                                )
                            )
                            .frame(width: breathingCircleSize(), height: breathingCircleSize())
                            .animation(.easeInOut(duration: phaseDuration()), value: currentPhase)
                        
                        // Phase text
                        VStack(spacing: 10) {
                            Text(currentPhase.rawValue.uppercased())
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("\(Int(phaseTimeRemaining))")
                                .font(.system(size: 48, weight: .light, design: .monospaced))
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }
                    
                    // Instructions
                    Text(instructionForPhase())
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 40)
                    
                    // Cycle counter and time remaining
                    HStack(spacing: 40) {
                        VStack {
                            Text("\(cycleCount)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("Cycles")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                        }
                        
                        VStack {
                            Text(timeString(from: timeRemaining))
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("Remaining")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }
                    
                    Spacer()
                    
                    // Control buttons
                    HStack(spacing: 40) {
                        Button(action: {
                            if isActive {
                                pauseTimers()
                            } else {
                                startTimers()
                            }
                        }) {
                            Image(systemName: isActive ? "pause.circle.fill" : "play.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                        }
                        
                        Button(action: {
                            stopTimers()
                            isPresented = false
                        }) {
                            Image(systemName: "stop.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            setupBreathingPattern()
            startTimers()
        }
        .onDisappear {
            stopTimers()
        }
    }
    
    private func setupBreathingPattern() {
        switch technique {
        case .box:
            phaseTimeRemaining = 4
        case .coherent:
            phaseTimeRemaining = 5
        case .wim:
            phaseTimeRemaining = 2
        case .alternate:
            phaseTimeRemaining = 4
        case .fire:
            phaseTimeRemaining = 1
        }
    }
    
    private func startTimers() {
        isActive = true
        
        // Main session timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                completeSession()
            }
        }
        
        // Breathing phase timer
        breathTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if phaseTimeRemaining > 0 {
                phaseTimeRemaining -= 1
            } else {
                nextPhase()
            }
        }
    }
    
    private func pauseTimers() {
        isActive = false
        timer?.invalidate()
        breathTimer?.invalidate()
    }
    
    private func stopTimers() {
        isActive = false
        timer?.invalidate()
        breathTimer?.invalidate()
        timer = nil
        breathTimer = nil
    }
    
    private func nextPhase() {
        switch technique {
        case .box:
            switch currentPhase {
            case .inhale:
                currentPhase = .hold
                phaseTimeRemaining = 4
            case .hold:
                currentPhase = .exhale
                phaseTimeRemaining = 4
            case .exhale:
                currentPhase = .holdEmpty
                phaseTimeRemaining = 4
            case .holdEmpty:
                currentPhase = .inhale
                phaseTimeRemaining = 4
                cycleCount += 1
            }
        case .coherent:
            switch currentPhase {
            case .inhale:
                currentPhase = .exhale
                phaseTimeRemaining = 5
            case .exhale:
                currentPhase = .inhale
                phaseTimeRemaining = 5
                cycleCount += 1
            default:
                currentPhase = .inhale
                phaseTimeRemaining = 5
            }
        case .wim:
            switch currentPhase {
            case .inhale:
                currentPhase = .exhale
                phaseTimeRemaining = 1
            case .exhale:
                currentPhase = .inhale
                phaseTimeRemaining = 2
                cycleCount += 1
            default:
                currentPhase = .inhale
                phaseTimeRemaining = 2
            }
        case .alternate, .fire:
            // Simplified patterns for these techniques
            switch currentPhase {
            case .inhale:
                currentPhase = .exhale
                phaseTimeRemaining = technique == .fire ? 0.5 : 4
            case .exhale:
                currentPhase = .inhale
                phaseTimeRemaining = technique == .fire ? 1 : 4
                cycleCount += 1
            default:
                currentPhase = .inhale
                phaseTimeRemaining = technique == .fire ? 1 : 4
            }
        }
    }
    
    private func completeSession() {
        stopTimers()
        
        // Add completed session to app state
        let session = BreathworkSession(
            technique: technique,
            duration: duration,
            date: Date(),
            completed: true
        )
        appState.addBreathworkSession(session)
        
        withAnimation(.easeInOut(duration: 0.5)) {
            showingCompletion = true
        }
    }
    
    private func breathingCircleSize() -> CGFloat {
        switch currentPhase {
        case .inhale:
            return 200
        case .hold:
            return 200
        case .exhale:
            return 100
        case .holdEmpty:
            return 100
        }
    }
    
    private func phaseDuration() -> TimeInterval {
        return phaseTimeRemaining
    }
    
    private func instructionForPhase() -> String {
        switch currentPhase {
        case .inhale:
            return "Breathe in slowly and deeply through your nose"
        case .hold:
            return "Hold your breath and feel the energy building"
        case .exhale:
            return "Release slowly through your mouth, letting go"
        case .holdEmpty:
            return "Rest in the empty space between breaths"
        }
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

enum BreathPhase: String {
    case inhale = "Inhale"
    case hold = "Hold"
    case exhale = "Exhale"
    case holdEmpty = "Hold Empty"
}

// MARK: - Breathwork Completion View
struct BreathworkCompletionView: View {
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "wind.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.cyan)
            
            Text("Breathwork Complete")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("You have transformed your energy through conscious breathing. Feel the vitality flowing through your entire being.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.8))
                .padding(.horizontal, 40)
            
            Button("Return Renewed") {
                onDismiss()
            }
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 200, height: 50)
            .background(
                LinearGradient(
                    colors: [.cyan, .blue],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(25)
        }
    }
}