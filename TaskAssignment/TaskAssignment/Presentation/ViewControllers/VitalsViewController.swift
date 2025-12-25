import UIKit

final class VitalsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: VitalsViewModel
    
    // MARK: - UI Components
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.register(VitalTableViewCell.self, forCellReuseIdentifier: VitalTableViewCell.identifier)
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
    init(viewModel: VitalsViewModel) {
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
        viewModel.loadVitals(patientId: "patient_001")
    }
    
    // MARK: - Setup
    private func setupUI() {
        navigationItem.title = "Vitals"
        view.backgroundColor = AppTheme.Colors.background
        
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
extension VitalsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].vitals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: VitalTableViewCell.identifier,
            for: indexPath
        ) as? VitalTableViewCell else {
            return UITableViewCell()
        }
        
        let vital = viewModel.sections[indexPath.section].vitals[indexPath.row]
        cell.configure(with: vital)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let label = UILabel()
        label.text = viewModel.sections[section].title
        label.font = AppTheme.Fonts.semibold(size: 13)
        label.textColor = AppTheme.Colors.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: AppTheme.Spacing.medium),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -AppTheme.Spacing.medium),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: AppTheme.Spacing.medium),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -AppTheme.Spacing.small)
        ])
        
        return headerView
    }
}

// MARK: - UITableViewDelegate
extension VitalsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

// MARK: - VitalsViewModelDelegate
extension VitalsViewController: VitalsViewModelDelegate {
    func vitalsDidUpdate() {
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
