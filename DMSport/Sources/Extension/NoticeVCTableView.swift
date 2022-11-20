import UIKit

extension NoticeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case entireNoticeTableView:
            if let entireCell = entireNoticeTableView
                .dequeueReusableCell(withIdentifier: "EntireNotice", for: indexPath) as? NoticeCell {
                entireCell.noticeTitle.text = "\(entireNoticeList[indexPath.row].title)"
                entireCell.noticeDetails.text = "\(entireNoticeList[indexPath.row].type)"
                entireCell.noticeContent.text = "\(entireNoticeList[indexPath.row].content)"
                entireCell.selectionStyle = .none
                return entireCell
            } else {
                return UITableViewCell()
            }
        case categoryTableView:
            if let categoryCell = categoryTableView
                .dequeueReusableCell(withIdentifier: "CategoryNotice", for: indexPath) as? NoticeCell {
                categoryCell.selectionStyle = .none
                categoryCell.noticeTitle.text = "\(categoryNoticeList[indexPath.row].title)"
                categoryCell.noticeDetails.text = "\(categoryNoticeList[indexPath.row].type) / \(categoryNoticeList[indexPath.row].created_at)"
                categoryCell.noticeContent.text = "\(categoryNoticeList[indexPath.row].content)"
                return categoryCell
            } else {
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
}
