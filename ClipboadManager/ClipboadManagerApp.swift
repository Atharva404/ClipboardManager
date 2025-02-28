//  ClipboadManagerApp.swift
//  ClipboadManager
//
//  Created by Atharva Gupta on 2/20/25.

import SwiftUI
import AppKit
import NaturalLanguage

struct ClipboardItem {
    let text: String
    var usageCount: Int = 0
    var lastUsed: Date = Date()
    var embedding: [Double] = []
}

@main
struct ClipboardManagerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {}
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var clipboardHistory: [ClipboardItem] = []
    var backupHistory: [ClipboardItem] = []
    let pasteboard = NSPasteboard.general
    let maxHistoryCount = 10
    let decayFactor: Double = 100000.0
    let maxTextLength = 50
    var lastChangeCount = NSPasteboard.general.changeCount

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupMenuBar()
        pasteboard.clearContents()
        startClipboardMonitoring()
        NSApp.setActivationPolicy(.accessory)
    }
    
    func setupMenuBar() {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusBarItem.button {
            button.image = NSImage(systemSymbolName: "doc.on.doc", accessibilityDescription: "Clipboard")
        }
        updateMenu()
    }
    
    func startClipboardMonitoring() {
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(checkClipboard), userInfo: nil, repeats: true)
    }
    
    @objc func checkClipboard() {
        guard pasteboard.changeCount != lastChangeCount else { return }
        lastChangeCount = pasteboard.changeCount
        if let newText = pasteboard.string(forType: .string), !clipboardHistory.contains(where: { $0.text == newText }) {
            let embedding = generateTextEmbedding(for: newText)
            let newItem = ClipboardItem(text: newText, embedding: embedding)
            clipboardHistory.append(newItem)
            if clipboardHistory.count > maxHistoryCount {
                removeLowPriorityItem()
            }
            updateMenu()
        }
    }

    func updateMenu() {
        let menu = NSMenu()
        menu.minimumWidth = 250

        let headerItem = NSMenuItem(title: "Clipboard Manager | Items: \(clipboardHistory.count)", action: nil, keyEquivalent: "")
        headerItem.isEnabled = false
        menu.addItem(headerItem)

        menu.addItem(NSMenuItem.separator())

        let totalUsageCount = clipboardHistory.reduce(0) { $0 + $1.usageCount }
        let contextItem = clipboardHistory.max(by: { $0.lastUsed < $1.lastUsed })

        let sortedHistory = clipboardHistory
            .sorted { calculatePredictiveScore(for: $0, withContext: contextItem) > calculatePredictiveScore(for: $1, withContext: contextItem) }

        for item in sortedHistory {
            let truncatedText = item.text.count > maxTextLength ? String(item.text.prefix(maxTextLength)) + "..." : item.text
            let usagePercentage = totalUsageCount > 0 ? Int((Double(item.usageCount) / Double(totalUsageCount)) * 100) : 0
            let menuItem = NSMenuItem(title: "\(truncatedText) (\(usagePercentage)%)", action: #selector(pasteText(_:)), keyEquivalent: "")
            menuItem.target = self
            menuItem.toolTip = item.text
            menu.addItem(menuItem)
            menu.addItem(NSMenuItem.separator())
        }

        let clearItem = NSMenuItem(title: "Clear History", action: #selector(clearHistory), keyEquivalent: "")
        clearItem.target = self
        menu.addItem(clearItem)
        
        if !backupHistory.isEmpty {
            let undoItem = NSMenuItem(title: "Undo Clear History", action: #selector(undoClearHistory), keyEquivalent: "")
            undoItem.target = self
            menu.addItem(undoItem)
        }

        statusBarItem.menu = menu
    }

    @objc func pasteText(_ sender: NSMenuItem) {
        pasteboard.clearContents()
        pasteboard.setString(sender.toolTip ?? sender.title, forType: .string)
        if let index = clipboardHistory.firstIndex(where: { $0.text == sender.toolTip }) {
            clipboardHistory[index].usageCount += 1
            clipboardHistory[index].lastUsed = Date()
        }
        updateMenu()
    }

  @objc func clearHistory() {
        backupHistory = clipboardHistory
        clipboardHistory.removeAll()
        pasteboard.clearContents()
        updateMenu()
    }
    
    @objc func undoClearHistory() {
        clipboardHistory = backupHistory
        backupHistory.removeAll()
        updateMenu()
    }

    @objc func removeLowPriorityItem() {
        guard !clipboardHistory.isEmpty else { return }
        clipboardHistory.sort { calculatePredictiveScore(for: $0, withContext: clipboardHistory.first) < calculatePredictiveScore(for: $1, withContext: clipboardHistory.first) }
        clipboardHistory.removeFirst()
    }

    func generateTextEmbedding(for text: String) -> [Double] {
        let embedding = NLEmbedding.sentenceEmbedding(for: .english)
        return embedding?.vector(for: text) ?? []
    }

    func calculatePredictiveScore(for item: ClipboardItem, withContext contextItem: ClipboardItem?) -> Double {
        let timeSinceLastUsed = Date().timeIntervalSince(item.lastUsed)
        var score = Double(item.usageCount) - (timeSinceLastUsed / decayFactor)
        if let context = contextItem, !item.embedding.isEmpty, !context.embedding.isEmpty {
            score += calculateSemanticSimilarity(vector1: item.embedding, vector2: context.embedding) * 10.0
        }
        return max(0, score)
    }
    func calculateSemanticSimilarity(vector1: [Double], vector2: [Double]) -> Double {
        guard vector1.count == vector2.count, !vector1.isEmpty else { return 0.0 }
        let dotProduct = zip(vector1, vector2).map(*).reduce(0, +)
        let magnitude1 = sqrt(vector1.map { $0 * $0 }.reduce(0, +))
        let magnitude2 = sqrt(vector2.map { $0 * $0 }.reduce(0, +))
        return dotProduct / (magnitude1 * magnitude2)
    }

}
