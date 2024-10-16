//
//  App Color , Fonts.swift
//  AfriSure
//
//  Created by iosdevelopment on 22/12/23.
//

import Foundation
import SwiftUI

//COLORS

let toolbarcolor = Color(red: 241/255.0, green: 94/255.0, blue: 85/255.0)

let backgroundViewColour = Color(red: 251/255.0, green: 237/255.0, blue: 224/255.0, opacity: 1)

let fontOrangeColour = Color(red: 241/255.0, green: 94/255.0, blue: 85/255.0)

let textFieldBorderColour = Color(red: 158/255.0, green: 144/255.0, blue: 144/255.0)

let inkBlueColour = Color(red: 11/255.0, green: 11/255.0, blue: 197/255.0)

let sykBlueColour = Color(red: 80/255.0, green: 196/255.0, blue: 237/255.0)

let TfBackgroundColor = Color(red: 242/255.0, green: 245/255.0, blue: 252/255.0)

let purpleColor = Color(red: 225/255.0, green: 194/255.0, blue: 253/255.0)

//FONTS

func isFontBlack(size: CGFloat) -> Font {
    return Font.custom("AntartidaRounded-Black", size: size)
}

func isFontMedium(size: CGFloat) -> Font {
    return Font.custom("AntartidaRounded-Medium", size: size)
}

func isFontLight(size: CGFloat) -> Font {
    return Font.custom("AntartidaRounded-Light", size: size)
}

func isFontBold(size: CGFloat) -> Font {
    return Font.custom("AntartidaRounded-Bold", size: size)
}
func isFontMediumItalic(size: CGFloat) -> Font {
    return Font.custom("AntartidaRounded-Mediumitalic", size: size)
}
