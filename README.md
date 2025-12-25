# DigitGroup-Task

This iOS app is built using Clean Architecture, keeping code easy to understand, test, and scale. It separates responsibilities into Data, Domain, and Presentation layers and uses MVVM + Coordinators for a clean UI flow.

*Data Layer
-Uses a MockDataSource to load local JSON files (patient, vitals, appointments)
-Simulates API calls with a small delay
-Repositories fetch data and expose it via protocols


*Domain Layer
-Contains core models: Patient, Vital, Appointment
-Defines repository protocols
-Keeps business logic independent of UI and data sources


*Presentation Layer
-Uses MVVM
-ViewModels fetch and prepare data
-ViewControllers only handle UI
-Coordinators manage navigation and screen flow


*Data Flow (Example)
-App starts → Coordinator sets up tabs
-View loads → ViewModel requests data
-MockDataSource reads JSON → returns decoded data
-ViewModel updates ViewController via delegates
-UI updates accordingly


*Key Highlights
-Clean Architecture
-MVVM + Coordinator pattern
-Protocol-based dependency injection
-Easy to swap mock data with real APIs later


*Instructions to run project
-Clone this project
-Open project and run file "TaskAssignment.xcodeproj"
-Project is made in Xcode 16.2, Make sure to run in 16.2 or above
