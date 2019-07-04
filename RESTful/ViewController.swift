import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var idTF: UITextField!
    
    @IBOutlet weak var creditTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getAllCourses(_sender: UIButton){
        let url = URL(string: "http://localhost:8080/courses")
        //let request = URLRequest(url: url!)
        //request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: url!){
            (data, response, error) in
            if let data = data{
                //print(data)
                do {
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as?[[String: Any]]
                    if let json = jsonSerialized{
                        print(json)
                    }
                } catch let error as NSError{
                    print(error.localizedDescription)
                }
            }else if let error = error{
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    
    @IBAction func getFirstCourse(_sender: UIButton){
        let url = URL(string: "http://localhost:8080/test")
        let task = URLSession.shared.dataTask(with: url!){
            (data, response, error) in
            if let data = data{
                //print(data)
                do {
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as?[String: Any]
                    if let json = jsonSerialized{
                        print(json)
                    }
                } catch let error as NSError{
                    print(error.localizedDescription)
                }
            }else if let error = error{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    @IBAction func createCourse(_sender: UIButton){
        let course: [String: Any] = ["courseTitle": "Swift", "courseID": "420-AS3", "credits": 5]
        let url = URL(string: "http://localhost:8080/course/create")
        var request = URLRequest(url: url!)
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        guard let body = try? JSONSerialization.data(withJSONObject: course, options: []) else {
            return
        }
        request.httpBody = body
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let json = jsonSerialized {
                        print(json)
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}


