//
//  ContentView.swift
//  MyCartUtils
//
//  Created by Pranup Kumar on 27/04/21.
//

struct ItemData : Identifiable, Equatable {
    let id = UUID()
    var itemStatus : Int
    var name : String
    var rating : Float
    var size : String
    var price : Int
    var imageName : String
    var customerName : String?
    var duration : String?
}

import SwiftUI

struct ContentView: View {
    
    @State var loanedItems : [ItemData] = []
    @State var availableItems : [ItemData] = [ItemData.init(itemStatus: 1, name: "Gray Coat Wool", rating: 4.3, size: "XL", price: 199, imageName: "1", customerName:                          "Alice Ray", duration: "27 Apr to 05 May"),
                                              ItemData.init(itemStatus: 0, name: "Slim Dress", rating: 4.6, size: "XL", price: 299, imageName: "2", customerName: nil, duration:nil),
                                              ItemData.init(itemStatus: 1, name: "Linen Dress White No Pattern", rating: 4.3, size: "XL", price: 199, imageName: "3", duration: "27 Apr to 05 May"),
                                              ItemData.init(itemStatus: 0, name: "White T Shirt", rating: 2.3, size: "M", price: 199, imageName: "4", customerName: nil, duration: "27 Apr to 05 May"),
                                              ItemData.init(itemStatus: 1, name: "Blue Jeans", rating: 4.9, size: "S", price: 199, imageName: "5", customerName: "Alice Ray", duration: "27 Apr to 05 May"),
                                              ItemData.init(itemStatus: 0, name: "Grey Shirt", rating: 3.3, size: "S", price: 199, imageName: "6", customerName: nil, duration: "27 Apr to 05 May"),
                                              ItemData.init(itemStatus: 0, name: "Black Shirt", rating: 3.3, size: "XXL", price: 199, imageName: "7", customerName: nil, duration: "27 Apr to 05 May"),
                                              ItemData.init(itemStatus: 0, name: "Cream Gown", rating: 4.1, size: "M", price: 199, imageName: "8", customerName: nil, duration: "27 Apr to 05 May"),
                                              ItemData.init(itemStatus: 1, name: "Red Saree", rating: 4.2, size: "L", price: 199, imageName: "9", customerName: "Alice Ray", duration: "27 Apr to 05 May"),
                                              ItemData.init(itemStatus: 1, name: "Black Trouer", rating: 4.9, size: "XS", price: 179, imageName: "10", customerName: "Bob", duration: "27 Apr to 05 May")
    ]
    @ObservedObject var contentController = ContentController()
    @State var offset : CGFloat = UIScreen.main.bounds.width*0
    @State var opacity = 1
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack{
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Button(action: {
                        self.opacity = 1
                        self.offset = self.width*0
                    })  {
                        VStack{
                            Text("LOANED ITEMS(\(self.loanedItems.count))")
                                .padding()
                                .font(.custom("OpenSans-SemiBold", size: 14))
                                .opacity(self.opacity == 1 ? 1 : 0.5)
                                .foregroundColor(.black)
                            VStack{
                                Capsule()
                                    .frame(width: "LOANED ITEMS(\("10"))".widthOfString(usingFont: UIFont.systemFont(ofSize:14, weight: .bold)), height: 3,alignment: .center)
                                    .foregroundColor(self.opacity == 1 ? Color(.black) : Color.clear)
                            }.padding(.top,-20)
                        }
                    }
                    Spacer()
                    Button(action: {
                        self.opacity = 0
                        self.offset = -self.width
                    })  {
                        VStack{
                            Text("AVAILABLE ITEMS(\(self.availableItems.count))")
                                .padding()
                                .font(.custom("OpenSans-SemiBold", size: 14))
                                .opacity(self.opacity == 0 ? 1 : 0.5)
                                .foregroundColor(.black)
                            VStack{
                                Capsule()
                                    .frame(width: "AVAILABLE ITEMS(\("10"))".widthOfString(usingFont: UIFont.systemFont(ofSize:14, weight: .bold)), height: 3,alignment: .center)
                                    .foregroundColor(self.opacity == 0 ? Color(.black) : Color.clear)
                            }.padding(.top,-20)
                        }
                    }
                    
                }.frame(width: UIScreen.main.bounds.width)
                
                
                GeometryReader{g in
                    HStack(spacing:0){
                        ZStack{
                            Color(.blue)
                                .opacity(0.05)
                            VStack{
                                Text("  Loaned Items")
                                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                                    .font(.custom("OpenSans-Bold", size: 20))
                                
                                ScrollView(.vertical,showsIndicators: false){
                                    ForEach(self.loanedItems){item in
                                        LoanedItemView(item: item, contentController: self.contentController)
                                            .highPriorityGesture(DragGesture()
                                                                    .onEnded({ (value) in
                                                                        if value.translation.width > 50{// minimum drag...
                                                                            print("right")
                                                                            self.availableItems.append(item)
                                                                            while self.loanedItems.contains(item) {
                                                                                if let index = loanedItems.firstIndex(of: item) {
                                                                                    loanedItems.remove(at: index)
                                                                                }
                                                                            }
                                                                        }
                                                                    }))
                                    }
                                }
                                Spacer()
                            }
                        }.frame(width: UIScreen.main.bounds.width)
                        .padding(.leading,0)
                        ZStack{
                            Color(.blue)
                                .opacity(0.05)
                            VStack{
                                Text("  Available Items")
                                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                                    .font(.custom("OpenSans-Bold", size: 20))
                                ScrollView(.vertical,showsIndicators: false){
                                    ForEach(self.availableItems){item in
                                        AvailableItemView(item: item, contentController: self.contentController)
                                            .highPriorityGesture(DragGesture()
                                                                    .onEnded({ (value) in
                                                                        if -value.translation.width > 50{
                                                                            print("left")
                                                                            self.loanedItems.append(item)
                                                                            while self.availableItems.contains(item) {
                                                                                if let index = availableItems.firstIndex(of: item) {
                                                                                    self.availableItems.remove(at: index)
                                                                                }
                                                                            }
                                                                        }
                                                                    }))
                                    }
                                }
                                Spacer()
                            }
                        }.frame(width: UIScreen.main.bounds.width)
                        
                    }.offset(x: self.offset)
                    .animation(.default)
                }
                Spacer()
            }
        }
    }
    
}


extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
