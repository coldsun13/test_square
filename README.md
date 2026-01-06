# square_test

## Architecture

### Redux-Inspired Feature Architecture (TCA-like)

This project uses a **Redux-inspired, feature-based architecture** similar to  
**The Composable Architecture (TCA)**.

The architecture is built around **explicit state management** and  
**unidirectional data flow**, ensuring predictable behavior and high testability.

---

## Architecture Diagram

```text
┌──────────────────────────────┐
│          SwiftUI View        │
│      (MainSquareView)        │
└───────────────┬──────────────┘
                │ sends Action
                ▼
┌──────────────────────────────┐
│            Action            │
│     (MainSquareAction)       │
└───────────────┬──────────────┘
                │
                ▼
┌──────────────────────────────────────────┐
│   Feature Logic (Reducer-like ViewModel)  │
│        MainSquareViewModel                │
│                                          │
│  • Handles actions                       │
│  • Runs async tasks                      │
│  • Calls dependencies                   │
└───────────────┬───────────────┬──────────┘
                │               │
        updates │               │ emits
        State   │               │ Side Effects
                ▼               ▼
┌──────────────────────┐   ┌──────────────────────┐
│        State         │   │     Side Effects      │
│  MainSquareState     │   │  loading / error     │
└──────────────┬───────┘   └──────────┬───────────┘
               │                      │
               │ observed by          │ handled by
               ▼                      ▼
┌──────────────────────────────┐   ┌──────────────────────────┐
│          SwiftUI View        │   │   UIKit Host Controller  │
│      renders UI              │   │ alerts / HUD / routing  │
└──────────────────────────────┘   └──────────────────────────┘

## Core Principles

### 1. Single Source of Truth per Feature
- Each feature maintains exactly one authoritative state
- No duplicated or conflicting data sources

### 2. Unidirectional Data Flow
Action → Feature Logic → State → UI
       ↘ Side Effects

- Data flows in one direction only
- Predictable state updates

### 3. Explicit Modeling
- **State**: All UI-related data
- **Action**: User and system events  
- **Side Effects**: External interactions (loading, errors, navigation)

### 4. UI as Pure Function of State
- UI renders based solely on current state
- No hidden dependencies or side effects in views

### 5. Side Effects Outside SwiftUI
- Side effects handled in UIKit layer
- SwiftUI remains declarative and pure

## Dependency Injection

### Why Swinject Is Used

**Swinject** is used as the dependency injection container to:

- Decouple features from concrete implementations  
- Enforce protocol-based design  
- Centralize dependency registration  
- Replace real services with mocks or stubs  
- Enable unit and UI testing  

### Benefits of Swinject in This Architecture

- Features depend only on **protocols**
- No `new` or hard-coded dependencies inside features
- Easy environment switching (**production / mock / UI tests**)
- Clean and explicit dependency boundaries

---

## Summary

This architecture is a **Feature-Based, Redux-style architecture inspired by TCA**, combining:

- Predictable state management  
- Explicit side-effect handling  
- Strong testability  
- Modular feature isolation  
- SwiftUI and UIKit interoperability  
