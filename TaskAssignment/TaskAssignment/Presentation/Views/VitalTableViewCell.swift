import UIKit

final class VitalTableViewCell: UITableViewCell {
    
    static let identifier = "VitalTableViewCell"
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppTheme.Colors.cardBackground
        view.layer.cornerRadius = AppTheme.CornerRadius.medium
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.semibold(size: 18)
        label.textColor = AppTheme.Colors.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.regular(size: 14)
        label.textColor = AppTheme.Colors.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.bold(size: 28)
        label.textColor = AppTheme.Colors.textPrimary
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let unitLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.regular(size: 12)
        label.textColor = AppTheme.Colors.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Fonts.medium(size: 12)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        iconContainerView.addSubview(iconImageView)
        containerView.addSubview(iconContainerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(valueLabel)
        containerView.addSubview(unitLabel)
        containerView.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppTheme.Spacing.medium),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppTheme.Spacing.medium),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            iconContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: AppTheme.Spacing.medium),
            iconContainerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconContainerView.widthAnchor.constraint(equalToConstant: 44),
            iconContainerView.heightAnchor.constraint(equalToConstant: 4),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 22),
            iconImageView.heightAnchor.constraint(equalToConstant: 22),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: AppTheme.Spacing.medium),
            nameLabel.leadingAnchor.constraint(equalTo: iconContainerView.trailingAnchor, constant: AppTheme.Spacing.small),
            
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -AppTheme.Spacing.small),
            
            valueLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AppTheme.Spacing.medium),
            
            unitLabel.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor),
            unitLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -4),
            
            statusLabel.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AppTheme.Spacing.medium)
        ])
    }
    
    // MARK: - Configuration
    func configure(with vital: Vital) {
        nameLabel.text = vital.type.displayName
        timeLabel.text = vital.timeAgo
        valueLabel.text = vital.displayValue
        unitLabel.text = vital.unit
        statusLabel.text = vital.status.displayName
        statusLabel.textColor = vital.status.color
        
        iconImageView.image = vital.type.icon
        iconContainerView.backgroundColor = vital.type.iconColor.withAlphaComponent(0.2)
        iconImageView.tintColor = vital.type.iconColor
    }
}
