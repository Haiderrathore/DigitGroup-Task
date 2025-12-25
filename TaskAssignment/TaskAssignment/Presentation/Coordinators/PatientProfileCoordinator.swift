import UIKit

final class PatientProfileCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let dependencyContainer: DependencyContainer
    
    init(navigationController: UINavigationController, dependencyContainer: DependencyContainer) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }
    
    func start() {
        showPatientProfile()
    }
    
    private func showPatientProfile() {
        let viewModel = PatientProfileViewModel(
            dataSource: dependencyContainer.makeDataSource(),
            coordinator: self
        )
        let viewController = PatientProfileViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
}
