# Project Global Engineering Rules

## 1) Clean code always
- Keep code clean, readable, and maintainable.
- Prefer clarity over **cleverness**.

## 2) Small files and functions
- Files and functions must stay small and focused.
- Strive for functions **less than 20 lines**.
- Avoid large classes or overly complex files.

## 3) Comments only when necessary
- Add comments only when the intent is not obvious.
- Use comments to explain **why** the code is written a certain way, not **what** it does.
- Do not add redundant or obvious comments.

## 4) Clean Architecture discipline (strict)
- Follow Clean Architecture layer boundaries strictly: **presentation → domain → data**.
- Each layer must have a single responsibility; never bypass layers.
- All business logic must reside in the **domain layer** and be triggered via **Cubit/UseCases**.
- **Note:** It is acceptable to use Flutter’s built-in state solutions (like `ValueNotifier` or `ChangeNotifier`) if they are better suited for the specific task or simpler than implementing full Cubit/UseCases.
- Data layer handles API calls, persistence, and data mapping only.
- Do not introduce unnecessary abstractions or overengineering.
- UI must only handle rendering, user interaction, and state observation.
- Never bypass layers or mix responsibilities.

## 5) Apply SOLID, DRY, and sound engineering principles
- Apply **SOLID**, **DRY**, and other sound engineering principles when beneficial.
- Do not force patterns unnecessarily.

## 6) Root-cause first
- Always identify and fix the **root cause**, not just symptoms.
- Do not apply superficial fixes.

## 7) Minimal safe changes
- Make the smallest possible change that solves the problem.
- Do not refactor unrelated code unless explicitly requested.

## 8) No breaking changes
- Do not break existing functionality, APIs, flows, or UX unless explicitly instructed.

## 9) Follow repository conventions
- Follow existing architecture, folder structure, naming conventions, and patterns.
- Do not introduce a new style inconsistent with the project.

## 10) Core folder for shared components
- Any reusable logic, utilities, services, constants, extensions, helpers, or shared components used in more than one place must be placed in the core/ folder.
- Avoid duplication across features.

## 11) Performance awareness & Visual Design

### Performance
- Follow Flutter performance best practices at all times.
- Avoid unnecessary widget rebuilds; use `const` constructors wherever possible.
- Use `setState` only for local UI state; never for business logic.
- **Avoid creating controllers** (`TextEditingController`, `AnimationController`) or `FocusNode` inside `build()`. (Follow **BPP & LAA** principles: Keep build pure and match object lifetimes to widget lifetimes).
- Use `compute()` or `isolate.run` for expensive calculations (e.g., JSON parsing) to avoid blocking the UI thread.
- Avoid heavy work inside build methods.
- Prefer Cubit/Bloc for managing feature and application state.
- Prefer efficient widget composition and separation to minimize rebuild scope.
### Visual Design
- Apply the **60-30-10 rule** for balanced color schemes (60% Primary/Neutral, 30% Secondary, 10% Accent).
- Use **multi-layered drop shadows** for depth and a "lifted" feel on cards.
- Apply **subtle noise textures** to main backgrounds for a premium feel.
- Use interactive elements with elegant color glows and shadows.

## 12) State management discipline
- Use **Cubit/Bloc** for feature state and business logic coordination.
- UI must only observe state and trigger actions.
- For simpler, local state, built-in solutions like `ValueNotifier` with `ValueListenableBuilder` are preferred.
- Do not bypass architecture layers.


## 13) Edge cases and error handling
- Properly handle null, empty, loading, and error states.
- **Data layer:** Catch exceptions and map them to typed `Failure`/`Error` classes.
- **Domain layer:** Return Result types (e.g., `Either<Failure, Success>`).
- Do not allow silent failures.
- Always ensure safe and predictable behavior.
- Errors must propagate cleanly: data → domain → presentation, never skip layers.

## 14) Dependencies rule
- Do not add new packages unless necessary and justified.
- Prefer standard/well-maintained packages like `go_router` for navigation and `google_fonts` for typography.
- Any package added must be:
  - Latest stable version
  - Well-maintained
  - Production-grade and trusted
  
## 15) Security awareness
- Never hardcode secrets, tokens, or credentials.
- Proactively warn about potential security risks.

## 16) Follow modern best practices & Code Generation
- **Modern Dart:** Use Dart 3+ features: `sealed class` for state unions, `switch` expressions, and `records` for data grouping.
- **Code Generation:** Avoid `Freezed` unless already adopted.
- Use `json_serializable` and `json_annotation` for JSON parsing when needed, using `fieldRename: FieldRename.snake`.
- Run code generation using: `dart run build_runner build --delete-conflicting-outputs`.

## 17) Team mindset & Interaction Guidelines
- **Persona:** Act as a senior engineer partner; suggest improvements and think critically.
- Explain tradeoffs briefly when relevant.
- **Explanations:** Provide clear explanations for Dart-specific features like null safety, futures, and streams.
- **Documentation:** Use `///` for doc comments on all public APIs; provide concise summaries.

## 18) No assumptions without verification
- Always read and understand relevant code before modifying it.

## 19) Avoid duplication
- Reuse existing logic; do not duplicate code unnecessarily.
- Do not assume behavior without verification.
- Ask or clearly state assumptions if something is unclear.

## 20) Dart naming conventions
- **Files:** `snake_case.dart`
- **Classes/Enums:** `PascalCase`
- **Variables/Functions/Constants:** `camelCase`
- Private members: prefix with `_`
- Feature folder structure: `feature_name/data/`, `feature_name/domain/`, `feature_name/presentation/`
- Follow Effective Dart guidelines for API design, usage, and documentation.

## 21) Import ordering
1. `dart:` SDK imports.
2. `package:flutter/` SDK imports.
3. Third-party `package:` imports.
4. Project `package:project_name/` imports.
- Use relative imports within the same feature.
- Use package imports across features.
- Never use unused imports.

## 22) Testing discipline
- Write unit tests for domain/data layers and widget tests for critical UI.
- Follow the **Arrange-Act-Assert** (Given-When-Then) pattern.
- Write widget tests for critical UI flows.
- Bug fixes must include a test that reproduces the issue.
- Follow existing test structure and naming conventions.
- Tests must be deterministic — no flaky or timing-dependent tests.
- Keep tests focused: one behavior per test case.

## 23) Separation of concerns enforcement
- Presentation layer must not directly access repositories.
- Domain layer must remain independent of Flutter and UI frameworks.
- All business operations must go through domain use cases.

## 24) Completion self-review checklist (mandatory)
- [ ] Root cause addressed? 
- [ ] Safe and minimal solution?
- [ ] Architecture respected? 
- [ ] No business logic in UI?
- [ ] No existing functionality is broken.
- [ ] Performance or security risks introduced?

Then provide a brief summary of:
- What was changed
- Why it was changed
- Why the solution is safe and correct
- add the new changes to file in the project that has the context of the app the most important parts for another AI agents ask me where is it if you can't see it in the normal ways his name will called project_context.md

## 25) Git and Pull Request output (mandatory)
- **Commit message:** Professional conventional commit 
