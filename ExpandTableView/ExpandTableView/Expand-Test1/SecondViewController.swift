




import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize sections data
        sections = [
            Section(title: "Section 1 - expand/collapse - skipped this section", items: ["Item 1", "Item 2"]),
            Section(title: "Section 2", items: ["Item 3", "Item 4"]),
            Section(title: "Section 3", items: ["Item 5", "Item 6"])
        ]
        
        // Register custom header view
//        tableView.register(SectionTableViewCell.self, forHeaderFooterViewReuseIdentifier: SectionTableViewCell.reuseIdentifier)
//        tableView.register(UINib(nibName: "SectionTableViewCell", bundle: nil), forCellReuseIdentifier: "SectionTableViewCell")
        tableView.register(UINib(nibName: "SectionTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionTableViewCell")
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {return 1}
        else {
            return sections[section].collapsed ? 0 : sections[section].items.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.nameLbl.text = sections[indexPath.section].items[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionTableViewCell") as! SectionTableViewCell
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionTableViewCell") as! SectionTableViewCell
        headerView.titleLbl.text = sections[section].title
        headerView.section = section
        if section == 0 {} else
        {
            headerView.delegate = self
            headerView.setCollapsed(sections[section].collapsed)}
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

extension SecondViewController: SectionHeaderViewDelegateTCell {
    func toggleSection(header: SectionTableViewCell, section: Int) {
        var indexPaths = [IndexPath]()
        for row in sections[section].items.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let collapsed = !sections[section].collapsed
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        if collapsed {
            tableView.deleteRows(at: indexPaths, with: .automatic)
        } else {
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
}
