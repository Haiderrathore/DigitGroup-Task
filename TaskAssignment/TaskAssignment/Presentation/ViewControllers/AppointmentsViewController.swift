import UIKit

final class AppointmentsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: AppointmentsViewModel
    
    // MARK: - UI Components
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Upcoming", "Past"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        
        control.setTitleTextAttributes([
            .foregroundColor: AppTheme.Colors.textSecondary,
            .font: AppTheme.Fonts.semibold(size: 16)
        ], for: .normal)
        
        control.setTitleTextAttributes([
            .foregroundColor: UIColor.white,
            .font: AppTheme.Fonts.semibold(size: 16)
        ], for: .selected)
        
        control.selectedSegmentTintColor = AppTheme.Colors.primaryBlue
        control.backgroundColor = AppTheme.Colors.cardBackground
        
        return control
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.register(AppointmentTableViewCell.self, forCellReuseIdentifier: AppointmentTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = AppTheme.Colors.primaryBlue
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Initialization
    init(viewModel: AppointmentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.loadAppointments(patientId: "patient_001")
    }
    
    // MARK: - Setup
    private func setupUI() {
        navigationItem.title = "Appointments"
        view.backgroundColor = AppTheme.Colors.background
        
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppTheme.Spacing.medium),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppTheme.Spacing.medium),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppTheme.Spacing.medium),
            segmentedControl.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: AppTheme.Spacing.medium),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func segmentChanged() {
        let newFilter: AppointmentFilter = segmentedControl.selectedSegmentIndex == 0 ? .upcoming : .past
        viewModel.setFilter(newFilter)
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension AppointmentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AppointmentTableViewCell.identifier,
            for: indexPath
        ) as? AppointmentTableViewCell else {
            return UITableViewCell()
        }
        
        let appointment = viewModel.filteredAppointments[indexPath.row]
        cell.configure(with: appointment)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AppointmentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appointment = viewModel.filteredAppointments[indexPath.row]
        viewModel.didSelectAppointment(appointment)
    }
}

// MARK: - AppointmentsViewModelDelegate
extension AppointmentsViewController: AppointmentsViewModelDelegate {
    func appointmentsDidUpdate() {
        tableView.reloadData()
    }
    
    func loadingStateDidChange(isLoading: Bool) {
        if isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
    
    func didReceiveError(_ error: Error) {
        showError(error)
    }
}
