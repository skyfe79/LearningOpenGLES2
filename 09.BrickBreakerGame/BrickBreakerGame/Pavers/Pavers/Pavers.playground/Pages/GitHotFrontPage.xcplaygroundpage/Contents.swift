import Pavers
import PaversUI
import UIKit

final class HitRepositoriesTableViewController: UIViewController {
  private lazy var tableView: UITableView =  UITableView()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.bindStyle()
  }


  private func bindStyle() {
    self.view.addSubview(self.tableView)
  }

  private func bindViewModel() {

  }
}

