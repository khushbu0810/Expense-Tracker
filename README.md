# 💸 Expense Tracker App

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-blue?style=for-the-badge)

A **cross-platform expense tracking application** built with Flutter, enabling users to record and manage their day-to-day expenses with a clean, responsive UI and native dialogs for both Android and iOS platforms.

---

## 📸 Screenshots

### 📱 Mobile View

![Mobile UI](https://github.com/khushbu0810/Expense-Tracker/blob/master/1000031271.jpg)


## 🚀 Key Features

- 🧾 **Form-driven Expense Input**: Capture title, amount, category, and date.
- 📅 **Custom Date Picker**: Intuitive calendar picker with platform awareness.
- 📊 **Category Dropdown**: Easily tag expenses (Work, Food, Travel, Leisure).
- ⚠️ **Robust Input Validation**: Handles nulls, empty values, and incorrect data types.
- 💬 **Platform-specific Alerts**: Uses `CupertinoAlertDialog` for iOS and `AlertDialog` for Android.
- 🧩 **Responsive Design**: Dynamic layout using `LayoutBuilder` to adapt to tablets and phones.
- 🧹 **Auto Dispose & Cleanup**: Ensures efficient memory management by disposing controllers.

---

## 🧠 Architecture & Concepts

| Concept                        | Usage in App                                  |
|--------------------------------|-----------------------------------------------|
| `StatefulWidget`               | For dynamic user input handling               |
| `TextEditingController`        | Tracks input for Title and Amount             |
| `DateTime?`                    | Optional date handling with null safety       |
| `Category enum`                | Custom type for expense classification        |
| `LayoutBuilder` + `MediaQuery` | Responsive layout adaptation                  |
| `Platform.isIOS`               | Platform-aware alert dialogs                  |

---

### ✅ Prerequisites

- Flutter SDK (3.0 or higher recommended)
- Dart SDK
- Android Studio / VS Code
- Android/iOS simulator or real device

---

## 🙋‍♀️ About the Author

**Khushbu Rani**  
B.Tech CSE Student @ VIT  
Machine Learning Enthusiast  
GitHub: [@khushbu0810](https://github.com/khushbu0810)  

