//
//  CommentViewController.swift
//  Instagram
//
//  Created by dslog sys on 2021/08/21.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentField: UITextField!

    // 投稿データを格納する配列
    var postArray: PostData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
                
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pushCommentButton(_ sender: Any) {

            // commentsを更新する
            if let myname = Auth.auth().currentUser?.displayName {
                // 更新データを作成する
                var updateValue: FieldValue
                // myidを追加する更新データを作成
                updateValue = FieldValue.arrayUnion([myname+": "+commentField.text!])

                // commentsに更新データを書き込む
                let postRef = Firestore.firestore().collection(Const.PostPath).document(postArray.id)
                postRef.updateData(["comments": updateValue])
                
                // HUDで投稿完了を表示する
                SVProgressHUD.showSuccess(withStatus: "投稿しました")
            }
        }
        
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
