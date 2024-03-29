import UIKit

class EditPhoneTableViewController: UITableViewController {
    convenience init() {
        self.init(style: .Grouped)
        let verifyBarButtonItem = UIBarButtonItem(title: "Verify", style: .Done, target: self, action: "verifyAction")
        verifyBarButtonItem.enabled = false
        navigationItem.rightBarButtonItem = verifyBarButtonItem
        title = "Phone Number"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(TextFieldTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(TextFieldTableViewCell))
    }

    // MARK: UITableViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(TextFieldTableViewCell), forIndexPath: indexPath) as! TextFieldTableViewCell
        let textField = cell.textField
        textField.addTarget(self, action: "textFieldDidChange:", forControlEvents: .EditingChanged)
        textField.clearButtonMode = .WhileEditing
        textField.keyboardType = UIKeyboardType.NumberPad
        textField.placeholder = "Phone Number"
        textField.text = account.user.phone
        textField.becomeFirstResponder()
        return cell
    }

    // MARK: Actions

    func textFieldDidChange(textField: UITextField) {
        let textLength = textField.text?.characters.count
        navigationItem.rightBarButtonItem?.enabled = (textLength == 10 && textField.text != account.user.phone)
    }

    func verifyAction() {
        print("Verify")
        //        myAccount.createCodeWithPhone(textField.text)
    }
}
