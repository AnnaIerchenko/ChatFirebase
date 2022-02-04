//
//  ChatList.swift
//  ChatFirebase
//
//  Created by Ierchenko Anna  on 2/1/22.
//

import SwiftUI

struct ChatList: View {
    
    @ObservedObject var viewModel = ChatroomsViewModel()
    @State var joinModel = false
    
    init() {
        viewModel.fetchData()
    }
    var body: some View {
        NavigationView {
            List(viewModel.chatrooms) { chatroom in
                NavigationLink(destination: Messages(chatroom: chatroom)) {
                HStack {
                    Text(chatroom.title)
                    Spacer()
                }
                }
            .navigationBarTitle("Chatrooms")
            .navigationBarItems(trailing: Button(action: {
                self.joinModel = true
            }, label: {
                Image(systemName: "plus.circle")
            }))
            .sheet(isPresented: $joinModel, content: {
                Join(isOpen: $joinModel)
                })
            }
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
