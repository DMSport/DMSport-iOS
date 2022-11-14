import UIKit

extension VoteVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let voteCell = tableView.dequeueReusableCell(withIdentifier: "TimeVoteCell", for: indexPath) as! TimeVoteCell
        voteCell.selectionStyle = .none
        voteCell.categoryLabel.text = "\(labelData[indexPath.row])"
        voteCell.leftMemebersLabel.text = "2/4명"
        voteCell.lunchDinnerLabel.text = "점심시간"
        
        return voteCell
    }
}

