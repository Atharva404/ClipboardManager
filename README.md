# 📋 Clipboard Manager

A powerful macOS menu bar application that enhances clipboard management with AI-driven smart suggestions. The Clipboard Manager app allows you to copy and manage multiple pieces of text efficiently, leveraging Natural Language Processing (NLP) to provide contextual and semantic-based clipboard suggestions.

---

## 🚀 Features

- 📑 **Multi-Clipboard Management:** Store and access multiple copied items from the macOS menu bar.
- 💡 **AI-Driven Smart Suggestions:** Utilizes NLP to prioritize clipboard items based on contextual relevance.
- 📈 **Usage-Based Prioritization:** Items are scored based on usage frequency, recency, and semantic similarity.
- 🧠 **Semantic Similarity Matching:** Uses Apple's Natural Language (NL) framework for advanced text embedding and similarity scoring.
- ⏪ **Undo Clear History:** Restore clipboard items if cleared by mistake.
- 🔥 **Automatic Cleanup:** Removes low-priority items when storage exceeds the limit.

---

## 🛠️ Installation

### Prerequisites
- macOS with Xcode installed.
- Git (optional for cloning the repository).

### Clone the Repository
```bash
git clone https://github.com/yourusername/ClipboardManager.git
cd ClipboardManager
```

### Open in Xcode
1. Open the `ClipboardManager.xcodeproj` file in Xcode.
2. Select your target and choose **Run** (`Cmd + R`) to build and start the app.

---

## 🚦 How to Use
1. The **Clipboard Manager** icon will appear in the **macOS menu bar**.
2. **Copy any text** to see it **added to the clipboard history**.
3. **Click the menu icon** to view and **select clipboard items**.
4. **Smart suggestions** will appear **based on recent selections**.
5. Use **Clear History** to remove all items and **Undo** to restore them if needed.

---

## 🧠 How It Works
- When you **copy text**, the app generates a **semantic embedding** using **NLP**.
- The **predictive score** for each item is calculated using:
  - **Usage frequency**
  - **Recency of use**
  - **Semantic similarity** to the **current context**
- Items are **prioritized** in the **menu** based on **predictive scores**.

---

## 💡 Contributing

1. **Fork the repository**
2. **Create a new branch** (`git checkout -b feature/my-feature`)
3. **Commit your changes** (`git commit -m 'Add some feature'`)
4. **Push to the branch** (`git push origin feature/my-feature`)
5. **Open a Pull Request**

---

## 📝 License
This project is licensed under the **MIT License**.

---

## 📧 Contact
For any questions, feel free to **reach out** or **create an issue** in the repository!

---

Enjoy using the **Clipboard Manager**! 😊

