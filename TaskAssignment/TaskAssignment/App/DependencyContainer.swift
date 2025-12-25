import Foundation

final class DependencyContainer {
    
    // MARK: - Data Sources
    private lazy var mockDataSource: DataSourceProtocol = {
        return MockDataSource()
    }()
    
    // MARK: - Repositories
    private lazy var patientRepository: PatientRepositoryProtocol = {
        return PatientRepository(dataSource: mockDataSource)
    }()
    
    private lazy var vitalRepository: VitalRepositoryProtocol = {
        return VitalRepository(dataSource: mockDataSource)
    }()
    
    private lazy var appointmentRepository: AppointmentRepositoryProtocol = {
        return AppointmentRepository(dataSource: mockDataSource)
    }()
    
    // MARK: - Data Source Factory
    func makeDataSource() -> DataSourceProtocol {
        return mockDataSource
    }
}
