import UIKit

extension CategoryNoticeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryNotice", for: indexPath) as? NoticeCell {
            cell.noticeTitle.text = "\(noticeList[indexPath.row].title)"
            cell.noticeDetails.text = "\(noticeList[indexPath.row].type) / \(noticeList[indexPath.row].created_at)"
            cell.noticeContent.text = "\(noticeList[indexPath.row].content)"
            
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
