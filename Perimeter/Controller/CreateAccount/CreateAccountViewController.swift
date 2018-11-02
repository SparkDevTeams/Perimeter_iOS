import UIKit

// This class creates a new account
class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        print("Sign up button tapped")
        
        // validate required fields are not empty
        if (userNameTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)! || (confirmPasswordTextField.text?.isEmpty)!
        {
            // Display Alrt message and return
            displayMessage(userMessage: "All fields are required")
            return
        }
        
        // validate required password parameters
        if isValidEmail(testStr: emailTextField.text!) != true
        {
            // Display an alert message and return
            displayMessage(userMessage: "Invalid Email")
            return
        }
        
        // validate required password parameters
        if isValidPassword(testStr: passwordTextField.text!) != true
        {
            // Display an alert message and return
            displayMessage(userMessage: "Password must at contain at least: \n \n 1 Capital letter \n1 Lower case \n 1 Special character \n 1 Number \n 8 Characters long")
            return
        }
    
        // Validate Password
        if ((passwordTextField.text?.elementsEqual(confirmPasswordTextField.text!))! != true)
        {
            // Display an alert message and return
            displayMessage(userMessage: "PLease make sure the passwords match")
            return
        }
        
        // Create activity indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // position activity indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // if needed, you can prevent activity indicator from hiding when stopANimationg is called
        myActivityIndicator.hidesWhenStopped = false
        
        // start activity indicator
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        // create new profile
        let profile = UserProfile(firstName: "", lastName: "", email: emailTextField.text!, profileImageUrl: nil, displayName: userNameTextField.text!)
        
        // adds profile to fire base
        FirebaseAPI().createAccount(profile: profile, password: passwordTextField.text!){(error, user) in
        
            // if there is no error go to main page, else display error message
            if error == nil{
                
                // let user know they successfully created account
                print("Created succesffuly")
                self.displayCongrats(userMessage: "Successfully created account :)")
                return
            }
            else {
                print(error as Any)
                self.displayMessage(userMessage: "There is already an account with this Email")
                return
            }
        }
        // removes indicator when inbox is reached
        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
    }
    // function to stop and remove indicator
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    // test email for correct format
    func isValidEmail(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        
        // must contain . @ and atleast 10 characters
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[@.]).{10,}")
        return emailTest.evaluate(with: testStr)
    }
    
    // test password for manditory characters
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // at least one special character
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$&*]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    // creates error message template
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction!) in
                // code in this block will trigger when OK button tapped
                print("OK button Tapped")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion:nil)
                }
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    // creates alert message for successful account creation
    func displayCongrats(userMessage:String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Congrats!", message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction!) in
                // code in this block will trigger when OK button tapped
                print("OK button Tapped")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion:nil)
                    
                    // go to main site
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.showMain()
                }
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    // function to go back to login screen
    @IBAction func signinPressed(_ sender: Any) {
        let signupSB = UIStoryboard(name: "Signup", bundle: nil)
        let signupVC = signupSB.instantiateViewController(withIdentifier: "SignupVC")
        show(signupVC, sender: self)
    }
}
