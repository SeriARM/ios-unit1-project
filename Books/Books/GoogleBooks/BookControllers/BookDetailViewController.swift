
import UIKit
import SafariServices


class BookDetailViewController: UIViewController {

    
    @IBOutlet var imageLink: [UIImageView]!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookDescription: UITextView!
    @IBOutlet weak var pageCountLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    @IBAction func readButtonAction(sender: Any) {
        readButton(readButton)
    }
    @IBOutlet weak var ratingControl: Rating!
    @IBAction func addBookshelf(_ sender: Any) {
        
      // Model.shared.addNewBook()
       // createNewArray()
        
        
    }
    
    var book: Book?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       UpdaiteView()
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(BookDetailViewController.tappedMe))
        bookImage.addGestureRecognizer(tap)
        bookImage.isUserInteractionEnabled = true
    }
    @objc func tappedMe()
    {
        if let url = book?.volumeInfo.infoLink {
            guard let baseURL = URL(string: url) else { fatalError("Unable to construct baseURL") }
            let svc = SFSafariViewController(url: baseURL); self.present(svc, animated: true, completion: nil)
    }
    }
  
    func readButton(_ sender: UIButton) {
        if sender.isSelected {
        sender.setTitle("Not Read", for: .normal)
        sender.isSelected = false
        } else {
        sender.setTitle("Read", for: .normal)
        sender.isSelected = true
        }
    }
   
    func UpdaiteView() {
        
        if let book = book {
        DispatchQueue.main.async {
            if let title = book.volumeInfo.title {
        self.bookTitle.text = title
        self.navigationItem.title = title
                
            } else {
                self.bookTitle.text = "No Title"
            }
            if let subtitle = book.volumeInfo.subtitle {
        self.subtitle.text = subtitle
            } else {
                self.subtitle.text = ""
            }
        if let author = book.volumeInfo.authors?.first {
            self.authorLabel.text = "Author: \(author)"
        } else {
            self.authorLabel.text = "No Author"
            }
            if let description = book.volumeInfo.description {
        self.bookDescription.text = description
            } else {
                self.bookDescription.text = "No Description"
            }
        guard let url = URL(string: book.volumeInfo.imageLinks?.smallThumbnail ?? "No image"),
            let imageData = try? Data(contentsOf: url) else { return }
        self.bookImage.image = UIImage(data: imageData)
        if let pages =  book.volumeInfo.pageCount {
            self.pageCountLabel.text = "Page count: \(String(describing: pages))"
        } else {
            self.pageCountLabel.text = ""
            }
           
            }
        } else {
             DispatchQueue.main.async {
            self.bookTitle.text = ""
            self.subtitle.text = ""
            self.authorLabel.text = ""
            self.bookDescription.text = ""
            self.pageCountLabel.text = ""
            self.bookImage.image = nil
    }
        }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
