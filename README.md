# 🍞 Toasty iOS alerts

<p align="left">
    <a href="https://swift.org">
        <img src="https://img.shields.io/badge/Swift-5.0-red.svg" />
    </a>
    <a href="https://cocoapods.org/pods/JDToaster">
        <img src="https://img.shields.io/cocoapods/v/JDToaster.svg" />
    </a>
    <a href="https://github.com/jdisho/JDToaster">
        <img src="https://img.shields.io/cocoapods/p/JDToaster.svg?style=flat" />
    </a>
</p>
A toast provides simple feedback in the bottom of the screen about an operation in an popup, which only fills the required amount of space for the message. The current popup remains visible until it’s manully dismissed or automaticaly after a given timeout. It doesn't interupt the user experience and doesn't require any user input to dismiss.

Similar to an `UIAlertController`, a toast is displayed in a separate `UIWindow`. 
This means that it’s presented on top of everything, regardless the view hierarchy. 

## 🛠 Installation

### CocoaPods

To integrate `JDToaster` into your Xcode project using `CocoaPods`, specify it in your `Podfile`:

```ruby
pod 'JDToaster'
```

Then, run the following command:

```bash
pod install
```

### Manually
If you prefer not to use any of the dependency managers, you can integrate `JDToaster` into your project manually, by downloading the source code and placing the files on your project directory.

## 👩‍💻 Usage

### The Basics

#### Display a toast

```swift 
Toaster.default.show(text: “Hello Toast!”)
```

#### Dismiss a toast

```swift 
Toaster.default.dismiss(animated: true)
```

### 🎨 Customizations

| Property                   | Type           | Default                                                          | Description                                                        |
|----------------------------|----------------|------------------------------------------------------------------|--------------------------------------------------------------------|
| `backgroundColor`          | `UIColor`      | `.black`                                                         | Background colour of the toast                                     |
| `font`                     | `UIFont`       | `.systemFont(ofSize: 17, weight: .medium)`                       | Font of the presented text                                         |
| `textColor`                | `UIColor`      | `.white`                                                         | Colour of the presented text                                       |
| `textInsets`               | `UIEdgeInsets` | `UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)` | Insets of the text within the toast                                |
| `cornerRadius`             | `CGFloat`      | `8.0`                                                            | Corner radius of the toast                                         |
| `bottomPadding`            | `CGFloat`      | `16.0`                                                           | The space between the toast bottom board and the bottom            |
| `minimumHorizontalPadding` | `CGFloat`      | `24.0`                                                           | The minimum space between the toast left/right board and the view. |

## ✨ Example
Checkout the [Example](https://github.com/jdisho/JDToaster/tree/master/Example) project

<p float="right">
    <img src="https://github.com/jdisho/JDToaster/blob/master/Images/Simulator%20Screen%20Shot%20-%20iPhone%20Xʀ%20-%202019-06-12%20at%2011.41.31.png" width="24%"/> 
    <img src="https://github.com/jdisho/JDToaster/blob/master/Images/Simulator%20Screen%20Shot%20-%20iPhone%20Xʀ%20-%202019-06-12%20at%2011.41.50.png" width="24%"/> 
    <img src="https://github.com/jdisho/JDToaster/blob/master/Images/Simulator%20Screen%20Shot%20-%20iPhone%20Xʀ%20-%202019-06-12%20at%2011.42.20.png" width="24%"/>
  </p>

## 🙏 Acknowledgments
- [Toaster](https://github.com/devxoul/Toaster) by [@devxoul](https://twitter.com/devxoul)
- [Squawk](https://github.com/GitHawkApp/Squawk) by [@_ryannystrom](https://twitter.com/_ryannystrom)
- [Custom View Controller Presentation Tips & Tricks](https://kylebashour.com/posts/custom-view-controller-presentation-tips) by [@kylebshr](https://twitter.com/kylebshr)

## 🐨 Author
This tiny library is created with ❤️ by [Joan Disho](https://twitter.com/_disho).

## 📃 License
`JDToaster` is released under an MIT license. See [License.md](https://github.com/jdisho/JDToaster/blob/master/LICENSE) for more information.



