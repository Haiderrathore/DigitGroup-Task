import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let dependencyContainer: DependencyContainer
    
    init(navigationController: UINavigationController, dependencyContainer: DependencyContainer) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }
    
    func start() {
        configureAppearance()
        showMainTabBar()
    }
    
    private func configureAppearance() {
        // Navigation bar appearance
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = AppTheme.Colors.cardBackground
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: AppTheme.Colors.textPrimary
        ]
        navigationBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: AppTheme.Colors.textPrimary
        ]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().tintColor = AppTheme.Colors.primaryBlue
    }
    
    private func showMainTabBar() {
        let tabBarController = MainTabBarController()
        
        // Access navigation controllers created by tab bar
        let navControllers = tabBarController.navigationControllers
        
        // Setup Vitals Tab
        let vitalsCoordinator = VitalsCoordinator(
            navigationController: navControllers[0],
            dependencyContainer: dependencyContainer
        )
        childCoordinators.append(vitalsCoordinator)
        vitalsCoordinator.start()
        
        // Setup Appointments Tab
        let appointmentsCoordinator = AppointmentsCoordinator(
            navigationController: navControllers[1],
            dependencyContainer: dependencyContainer
        )
        childCoordinators.append(appointmentsCoordinator)
        appointmentsCoordinator.start()
        
        // Setup Patient Profile Tab
        let profileCoordinator = PatientProfileCoordinator(
            navigationController: navControllers[2],
            dependencyContainer: dependencyContainer
        )
        childCoordinators.append(profileCoordinator)
        profileCoordinator.start()
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}
