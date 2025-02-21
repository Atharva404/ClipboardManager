📋 Clipboard Manager

Clipboard Manager is a macOS menu bar application designed to enhance productivity by allowing users to store, manage, and efficiently paste multiple clipboard items directly from the menu bar. The app is equipped with AI-driven features to provide smart suggestions and predictive sorting based on usage patterns and semantic similarity.

🚀 Features

🔢 Multi-Clipboard Management

Store multiple clipboard items with quick access in the menu bar.

Automatically monitor clipboard changes and update the menu.

🎯 AI-Driven Smart Suggestions

Natural Language Processing (NLP) to compute semantic similarity between clipboard items.

Predictive scoring algorithm prioritizes frequently used or contextually relevant items.

Cosine similarity used to match context and boost suggestions.

🧠 Intelligent Cleanup

Uses predictive scoring to automatically remove low-priority items when the history limit is reached.

Prevents negative scores to ensure relevant items are retained.

♻️ Clipboard History Management

Clear History option to remove all clipboard items.

Undo Clear History to restore the previous state.

🖥️ Clean and Minimal UI

Displays clipboard items with usage percentages.

Right-aligned percentages for a polished look.

Dividers between clipboard items for visual clarity.

🛠️ How It Works

Clipboard Monitoring: Continuously monitors the macOS clipboard.

Embedding Generation: Generates NLP embeddings using Apple's Natural Language framework.

Predictive Scoring: Calculates a score for each clipboard item based on usage frequency, time since last used, and semantic similarity.

Smart Suggestions: Sorts items by relevance using cosine similarity.
