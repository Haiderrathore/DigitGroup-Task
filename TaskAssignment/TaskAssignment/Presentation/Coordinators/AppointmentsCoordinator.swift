import UIKit

final class AppointmentsCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let dependencyContainer: DependencyContainer
    
    init(navigationController: UINavigationController, dependencyContainer: DependencyContainer) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }
    
    func start() {
        showAppointments()
    }
    
    private func showAppointments() {
        let viewModel = AppointmentsViewModel(
            dataSource: dependencyContainer.makeDataSource(),
            coordinator: self
        )
        let viewController = AppointmentsViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showAppointmentDetails(appointment: Appointment) {
        let viewModel = AppointmentDetailsViewModel(
            appointmentId: appointment.id,
            dataSource: dependencyContainer.makeDataSource(),
            coordinator: self
        )
        let viewController = AppointmentDetailsViewController(viewModel: viewModel, appointment: appointment)
        navigationController.pushViewController(viewController, animated: true)
    }
}
