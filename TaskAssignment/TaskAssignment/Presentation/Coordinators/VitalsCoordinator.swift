import UIKit

final class VitalsCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let dependencyContainer: DependencyContainer
    
    init(navigationController: UINavigationController, dependencyContainer: DependencyContainer) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }
    
    func start() {
        showVitals()
    }
    
    private func showVitals() {
        let viewModel = VitalsViewModel(
            dataSource: dependencyContainer.makeDataSource(),
            coordinator: self
        )
        let viewController = VitalsViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
}
