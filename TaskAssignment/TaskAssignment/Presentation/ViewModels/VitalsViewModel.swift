import Foundation

struct VitalSection {
    let title: String
    let vitals: [Vital]
}

protocol VitalsViewModelDelegate: AnyObject {
    func vitalsDidUpdate()
    func loadingStateDidChange(isLoading: Bool)
    func didReceiveError(_ error: Error)
}

final class VitalsViewModel {
    // MARK: - Properties
    private let dataSource: DataSourceProtocol
    private weak var coordinator: VitalsCoordinator?
    weak var delegate: VitalsViewModelDelegate?
    
    private(set) var sections: [VitalSection] = []
    
    // MARK: - Initialization
    init(dataSource: DataSourceProtocol, coordinator: VitalsCoordinator) {
        self.dataSource = dataSource
        self.coordinator = coordinator
    }
    
    // MARK: - Methods
    func loadVitals(patientId: String) {
        delegate?.loadingStateDidChange(isLoading: true)
        
        dataSource.fetchVitals(patientId: patientId) { [weak self] result in
            guard let self = self else { return }
            
            self.delegate?.loadingStateDidChange(isLoading: false)
            
            switch result {
            case .success(let vitals):
                self.sections = self.groupVitalsByDate(vitals)
                self.delegate?.vitalsDidUpdate()
            case .failure(let error):
                self.delegate?.didReceiveError(error)
            }
        }
    }
    
    private func groupVitalsByDate(_ vitals: [Vital]) -> [VitalSection] {
        let calendar = Calendar.current
        
        // Group vitals by date
        let grouped = Dictionary(grouping: vitals) { vital -> String in
            if calendar.isDateInToday(vital.recordedAt) {
                return "TODAY"
            } else if calendar.isDateInYesterday(vital.recordedAt) {
                return "YESTERDAY"
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM d, yyyy"
                return formatter.string(from: vital.recordedAt).uppercased()
            }
        }
        
        // Sort sections and vitals within sections
        let sortedSections = grouped.map { key, vitals in
            VitalSection(
                title: key,
                vitals: vitals.sorted { $0.recordedAt > $1.recordedAt }
            )
        }.sorted { section1, section2 in
            // Today first, then Yesterday, then older dates
            if section1.title == "TODAY" { return true }
            if section2.title == "TODAY" { return false }
            if section1.title == "YESTERDAY" { return true }
            if section2.title == "YESTERDAY" { return false }
            return section1.title > section2.title
        }
        
        return sortedSections
    }
}
