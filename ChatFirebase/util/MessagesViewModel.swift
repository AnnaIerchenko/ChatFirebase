//
//  MessagesViewModel.swift
//  ChatFirebase
//
//  Created by Ierchenko Anna  on 2/2/22.
//

import Foundation
import Firebase


struct Message: Codable, Identifiable {
    var id: String?
    var content: String
    var name: String
    
}

class MessagesViewModel: ObservableObject {
    @Published var messages = [Message]()  //update interface
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    func sendMessage(messageContent: String, docId: String) {
        if (user != nil) {
            db.collection("chatrooms").document(docId).collection("messages").addDocument(data: [
                "sentAt": Date(),
                "displayName": user!.email,
                "contact": messageContent,
                "sender": user!.uid])
        }
    }
    
    func fetchData(docId: String) {
        if (user != nil) {
            db.collection("chatrooms").document(docId).collection("messages").order(by: "sentAt", descending: false).addSnapshotListener({(snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("no documents")
                    return
                }
                
                self.messages = documents.map {docSnapshot -> Message in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let content = data["content"] as? String ?? ""
                    let displayName = data["displayName"] as? String ?? ""
                    return Message(id: docId, content: content, name: displayName)
                }
            })
        }
    }
}
