# Flutter Cheat Sheet Repository

A personal, organized collection of Flutter resources, components, bug fixes, package usage, commands, permissions handling, services and deployment guides. Use this repo as your go-to reference when working on any Flutter project.

## 📑 Table of Contents

* [Components](#components)
* [Bugs & Errors](#bugs--errors)
* [Packages](#packages)
* [Commands & Scripts](#commands--scripts)
* [Permissions](#permissions)
* [Services](#services)
* [Deployment Guides](#deployment-guides)
* [Assets & Diagrams](#assets--diagrams)
* [Tools & Automation](#tools--automation)
* [Contributing](#contributing)
* [License](#license)

---

## Components

**Path:** `components/`  
Each widget lives in its own folder:

```
components/
└── Dropdown/
    ├── custom_multi_selector_dropdown.dart
    └── example.dart
```

- **custom_widgets.md** – index of all custom widgets with brief descriptions and links.

---

## Bugs & Errors

**Path:** `bugs/`

```
bugs/
├── null_safety_error.md
└── widget_not_building.md
```

Each file contains:

- Error description & logs
- Root cause analysis
- Step-by-step solutions
- External references

---

## Packages

**Path:** `packages/`

```
packages/
├── provider.md
└── dio.md
```

Each package file includes:

- Installation & setup
- API overview
- Common pitfalls & solutions
- Code snippets

---

## Commands & Scripts

**Path:** `commands/`

```
commands/
├── flutter_commands.md
└── deployment.md
```

- **flutter_commands.md** – Flutter & Dart CLI cheatsheet
- **deployment.md** – CI/CD examples and scripts for Google Play & App Store

---

## Permissions

**Path:** `permissions/ios/bluetooth/`

```
permissions/
└── ios/
    └── bluetooth/
        ├── bluetooth_permission.dart
        └── bluetooth.md
```

- **bluetooth_permission.dart** – code to check & request Bluetooth permissions
- **bluetooth.md** – explanation of iOS Podfile flags, Info.plist entries, and usage

---

## Services

**Path:** `services/`

```
services/
├── app_update/
│   ├── app_update_manager.dart
│   └── app_update.md
└── socket/
    ├── socket_service.dart
    └── socket.md
```

- **App Update Service** (`app_update/`)
  - `app_update_manager.dart` – singleton for forced/optional update checks
  - `app_update.md` – setup, features, use-cases, and usage snippets

- **Socket Service** (`socket/`)
  - `socket_service.dart` – singleton wrapper around `socket_io_client`
  - `socket.md` – initialization, event handling, reconnection logic, and examples

---

## Deployment Guides

**Path:** `deployment/`

```
deployment/
└── google play/
    ├── projects_before_flutter_3.29.md
    ├── projects_started_from_flutter_3.29.md
    └── deployment.md
```

- Google Play: keystore, versioning, AAB build & upload, GitHub Actions
- App Store: _(coming soon in `deployment/apple_store.md`)_

---

## Assets & Diagrams

**Path:** `assets/diagrams/`

- Architecture diagrams
- Flowcharts
- UI mockups

---

## Tools & Automation

**Path:** `tools/`

- Scripts to auto-generate TOC
- Folder cleanup utilities
- Documentation build pipelines

---

## Contributing

1. Fork this repository
2. Create a feature/fix branch
3. Update the relevant folder and `.md` file(s)
4. Open a pull request with a clear description

---

## License

MIT
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.