//
//  CommentView.swift
//  Foody
//
//  Created by An Nguyễn on 2/28/21.
//

import SwiftUI

struct CommentView: View {
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading) {
                        Text("Ellen McLaughlin")
                            .bold(size: 15)
                        Text("2 hours ago")
                            .regular(size: 12)
                            .foregroundColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1).color)
                    }
                    Spacer()
                    VotesView(numberOfVotes: 4, size: 12)
                }
                
                Text("So we needed up ordering the deep fried salmon roll with Chinese hot mustard and wasabi noodles with salmon.")
                    .regular(size: 14)
                    .padding(.top, 10)
            }
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
