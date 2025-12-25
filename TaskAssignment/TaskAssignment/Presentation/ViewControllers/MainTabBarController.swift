import UIKit

final class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private(set) var navigationControllers: [UINavigationController] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        view.backgroundColor = .clear
        setupTabBar()
    }
    
    // MARK: - Setup
    private func setupTabBar() {
        // Create navigation controllers
        navigationControllers = AppTabBars.allCases.map { tabConfig in
            let navController = UINavigationController()
            
            let tabBarItem = UITabBarItem(
                title: tabConfig.title,
                image: tabConfig.image,
                selectedImage: tabConfig.selectedImage
            )
            navController.tabBarItem = tabBarItem
            
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = AppTheme.Colors.cardBackground
            appearance.titleTextAttributes = [.foregroundColor: AppTheme.Colors.textPrimary]
            
            navController.navigationBar.standardAppearance = appearance
            navController.navigationBar.scrollEdgeAppearance = appearance
            navController.navigationBar.compactAppearance = appearance
            
            return navController
        }
        
        self.viewControllers = navigationControllers
        self.selectedIndex = 0
        
        // Tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppTheme.Colors.cardBackground
        appearance.shadowColor = UIColor(white: 0.2, alpha: 1)
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: AppTheme.Colors.textSecondary
        ]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: AppTheme.Colors.primaryBlue
        ]
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}

// MARK: - Tab Bar Configuration
fileprivate enum AppTabBars: Int, CaseIterable {
    case vitals = 0
    case appointments = 1
    case profile = 2
    
    var title: String {
        switch self {
        case .vitals: return "Vitals"
        case .appointments: return "Appointments"
        case .profile: return "Profile"
        }
    }
    
    var image: UIImage {
        let systemName: String
        switch self {
        case .vitals: systemName = "waveform.path.ecg"
        case .appointments: systemName = "calendar"
        case .profile: systemName = "person.circle"
        }
        return UIImage(systemName: systemName)!
            .withTintColor(AppTheme.Colors.textSecondary, renderingMode: .alwaysOriginal)
    }
    
    var selectedImage: UIImage {
        let systemName: String
        switch self {
        case .vitals: systemName = "waveform.path.ecg"
        case .appointments: systemName = "calendar"
        case .profile: systemName = "person.circle.fill"
        }
        return UIImage(systemName: systemName)!
            .withTintColor(AppTheme.Colors.primaryBlue, renderingMode: .alwaysOriginal)
    }
}
