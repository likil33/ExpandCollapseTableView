
import UIKit


protocol SectionHeaderViewDelegateTCell: AnyObject {
    func toggleSection(header: SectionTableViewCell, section: Int)
}

class SectionTableViewCell: UITableViewHeaderFooterView { //UITableViewCell {
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dropImg: UIImageView!

    
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    let arrowImageView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(systemName: "down"))
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    var section: Int = 0
    weak var delegate: SectionHeaderViewDelegateTCell?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        contentView.addGestureRecognizer(tapGesture)
        
//        NSLayoutConstraint.activate([
//            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            
//            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
//            arrowImageView.heightAnchor.constraint(equalToConstant: 24)
//        ])
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
    
    
//    override init(reuseIdentifier: String?) {
//        super.init(reuseIdentifier: reuseIdentifier)
//        
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(arrowImageView)
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
//        contentView.addGestureRecognizer(tapGesture)
//        
//        NSLayoutConstraint.activate([
//            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            
//            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
//            arrowImageView.heightAnchor.constraint(equalToConstant: 24)
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    @objc func headerTapped() {
        delegate?.toggleSection(header: self, section: section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        dropImg.image = collapsed ? UIImage(systemName: "down") : UIImage(systemName: "up")
    }
    
}
