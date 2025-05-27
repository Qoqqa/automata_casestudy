# Sequences and Algorithms

## Overview
This project is a modern Flutter application for exploring and visualizing classic mathematical sequences and algorithms. The app features a unified, animated UI/UX and interactive pages for each algorithm, making it ideal for learning and demonstration purposes.

## Features
- Beautiful, consistent card-based UI for all algorithm pages
- Animated backgrounds and header icons for each sequence/algorithm
- Easy-to-edit descriptions for each algorithm
- Robust error/result handling with fade-in cards
- Copy-to-clipboard for results and sequences
- Floating action buttons for quick navigation
- Custom app icon and branding
- Algorithms included:
  - Fibonacci Sequence
  - Lucas Sequence
  - Tribonacci Sequence
  - Collatz Conjecture
  - Euclidean Algorithm (GCD)
  - Pascal's Triangle

## Folder Structure
```
project_root/
├── lib/
│   ├── main.dart                # App entry point
│   ├── homepage.dart            # Main navigation and UI
│   ├── fibonacci_page.dart      # Fibonacci sequence page
│   ├── lucas_page.dart          # Lucas sequence page
│   ├── tribonacci_page.dart     # Tribonacci sequence page
│   ├── collatz_page.dart        # Collatz conjecture page
│   ├── euclidean_page.dart      # Euclidean algorithm (GCD) page
│   ├── pascal_page.dart         # Pascal's Triangle page
│   └── icons/
│       ├── appicon.png          # App launcher icon
│       └── fibonacci.png        # Custom Fibonacci icon
├── pubspec.yaml                 # Dependencies and assets
├── README.md                    # Project documentation
├── android/                     # Android platform code
├── ios/                         # iOS platform code
├── linux/                       # Linux platform code
├── macos/                       # macOS platform code
├── web/                         # Web platform code
├── windows/                     # Windows platform code
└── test/                        # Widget and unit tests
```

## Setup Instructions
1. **Clone the repository:**
   ```sh
   git clone https://github.com/Qoqqa/automata_casestudy.git
   cd automata_casestudy
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **Run the application:**
   ```sh
   flutter run
   ```

## Usage
- Select an algorithm from the homepage to explore its interactive page.
- Enter input values and generate results.
- Copy results to clipboard using the copy button.
- Use the floating action button to quickly scroll to the top.

## Contributors
- Caasi, Asilito
- Colarina, Ricardo Jose

---
This app is for educational and demonstration purposes. Enjoy exploring sequences and algorithms!