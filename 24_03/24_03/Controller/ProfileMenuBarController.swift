import UIKit

class ProfileMenuBarController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!
    let buttonText = ["All Theatres","Coming Soon","My Bookings","Privilege","My Preferences","Gift Cards", "Offers","PVR Magazine","Contact Us","T&C | Privacy"]
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ProfileMenuBarController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return buttonText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "SildeMenuTableViewCellid")as! SildeMenuTableViewCell
        cell.buttonTextSet.setTitle(buttonText[indexPath.row], for: .normal)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
