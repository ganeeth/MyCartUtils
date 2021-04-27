//
//  LoanedItemView.swift
//  MyCartUtils
//
//  Created by Pranup Kumar on 27/04/21.
//

import SwiftUI

struct LoanedItemView: View {
    
    @State var item : ItemData
    @ObservedObject var contentController : ContentController
        
    var body: some View {
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
            HStack{
                Image("\(item.imageName)").resizable()
                    .frame(width: 120, height: 100, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack(alignment: .leading){
                    Spacer()
                    Text("\(item.name)")
                    .font(.custom("OpenSans-SemiBold", size: 14))
                    Spacer()
                    Text("BRAND NAME")
                        .font(.custom("OpenSans-SemiBold", size: 12))
                        .foregroundColor(Color.gray)
                    Spacer()
                    HStack{
                        Text("$\(item.price)")
                            .font(.custom("OpenSans-Bold", size: 12))
                            .foregroundColor(Color.black)
                        Text("TOTAL")
                            .font(.custom("OpenSans-Bold", size: 10))
                        Text("US")
                            .font(.custom("OpenSans-Bold", size: 10))
                        Text("\(item.size)")
                            .font(.custom("OpenSans-Bold", size: 12))
                            .foregroundColor(Color.black)
                        Image(systemName: "star.fill").renderingMode(.template)
                            .foregroundColor(.yellow)
                        Text("\(String(format: "%.1f",item.rating))")
                            .font(.custom("OpenSans-Bold", size: 12))
                        Image(systemName: "eye").renderingMode(.template)
                        Text("12")
                            .font(.custom("OpenSans-Bold", size: 12))
                    }.font(.headline)
                    .foregroundColor(Color.gray)
                    Spacer()
                }
            }
        }.frame(width: UIScreen.main.bounds.width-20, height: 100, alignment: .center)
    }
}

//struct LoanedItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoanedItemView(item: item: ItemData.init(itemStatus: 1, name: "Name", rating: 4.5, size: "XL", price: 199, imageName: "Suite", customerName: "Customer", duration: "3 days"), index: 1, contentController: ContentController())
//    }
//}
