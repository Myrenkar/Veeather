import UIKit

func fontStyle(ofSize size: CGFloat, weight: UIFont.Weight) -> (UILabel) -> Void {
  return {
    $0.font = .systemFont(ofSize: size, weight: weight)
  }
}

func textColorStyle(_ color: UIColor) -> (UILabel) -> Void {
  return {
    $0.textColor = color
  }
}

func backgroundColorStyle(_ color: UIColor) -> (UILabel) -> Void {
  return {
    $0.backgroundColor = color
  }
}

let centerStyle: (UILabel) -> Void = {
  $0.textAlignment = .center
}
