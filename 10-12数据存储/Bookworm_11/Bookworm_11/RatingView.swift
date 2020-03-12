//
//  RatingView.swift
//  Bookworm_11
//
//  Created by DR_Kun on 2020/3/9.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            ForEach(1..<maximumRating + 1) { num in
                self.image(for: num)
                    .foregroundColor(num > self.rating ? self.offColor : self.onColor)
                    .accessibility(label: Text("\(num == 1 ? "1 star" : "\(num) stars")"))
                    .accessibility(removeTraits: .isImage) // 去除掉 image 旁白
                    .accessibility(addTraits: num > self.rating ? .isButton : [.isButton, .isSelected]) // .isSelected 突出显示星号
                    .onTapGesture {
                        self.rating = num
                }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
