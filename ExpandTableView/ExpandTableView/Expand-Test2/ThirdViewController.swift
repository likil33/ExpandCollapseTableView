
import UIKit

struct SectionModel {
    let title:String
    var collapsed:Bool
    let items:[String]
    init(title: String, collapsed: Bool, items:[String]) {
        self.title = title
        self.collapsed = collapsed
        self.items = items
    }
}

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sectionsList = [SectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize sections data
        sectionsList = [SectionModel(title: "section1", collapsed: false, items: ["Item 1", "Item 2"]),
                        SectionModel(title: "section2", collapsed: false, items: ["Item 3", "Item 4"]),
                        SectionModel(title: "section3", collapsed: true, items: ["Item 3", "Item 4"]),
                        SectionModel(title: "section4", collapsed: true, items: ["Item 3", "Item 4"]),
                        SectionModel(title: "section5", collapsed: true, items: ["Item 3", "Item 4"]),
                        SectionModel(title: "section6", collapsed: true, items: ["Item 3", "Item 4"])
        ]
        
        // Register custom header view
        tableView.register(UINib(nibName: "SectionTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionTableViewCell")
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sectionsList[section].collapsed ? 0 : sectionsList[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.nameLbl.text = sectionsList[indexPath.section].items[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionTableViewCell") as! SectionTableViewCell
        headerView.titleLbl.text = sectionsList[section].title
        headerView.section = section
        headerView.delegate = self
        headerView.setCollapsed(sectionsList[section].collapsed)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

extension ThirdViewController: SectionHeaderViewDelegateTCell {
    func toggleSection(header: SectionTableViewCell, section: Int) {
        var indexPaths = [IndexPath]()
        for row in sectionsList[section].items.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let collapsed = !sectionsList[section].collapsed
        sectionsList[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        if collapsed {
            tableView.deleteRows(at: indexPaths, with: .automatic)
        } else {
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
}
