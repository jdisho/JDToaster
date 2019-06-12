# 🍞 Toasty iOS alerts

A toast provides simple feedback in the bottom of the screen about an operation in an popup, which only fills the required amount of space for the message. The current popup remains visible until it’s manully dismissed or automaticaly after a given timeout. It doesn't interupt the user experience and doesn't require any user input to dismiss.

Similar to an `UIAlertController `, a toast is displayed in a separate `UIWindow`. 
This means that it’s presented on top of everything, regardless the view hierarchy. 

## Usage

### Installation

#### CocoaPods

To integrate `JDToaster` into your Xcode project using `CocoaPods`, specify it in your `Podfile`:

```ruby
pod 'JDToaster'
```

Then, run the following command:

```bash
pod install
```

### The Basics

#### Display a toast

```swift 
Toaster.default.show(text: “Hello Toast!”)
```

#### Dismiss a toast

```swift 
Toaster.default.dismiss(animated: true)
```

### Customizations

A toast is customizable. 

| Property                   | Type           | Default                                                          | Description                                                        |
|----------------------------|----------------|------------------------------------------------------------------|--------------------------------------------------------------------|
| `backgroundColor`          | `UIColor`      | `.black`                                                         | Background colour of the toast                                     |
| `font`                     | `UIFont`       | `.systemFont(ofSize: 17, weight: .medium)`                       | Font of the presented text                                         |
| `textColor`                | `UIColor`      | `.white`                                                         | Colour of the presented text                                       |
| `textInsets`               | `UIEdgeInsets` | `UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)` | Insets of the text within the toast                                |
| `cornerRadius`             | `CGFloat`      | `8.0`                                                            | Corner radius of the toast                                         |
| `bottomPadding`            | `CGFloat`      | `16.0`                                                           | The space between the toast bottom board and the bottom            |
| `minimumHorizontalPadding` | `CGFloat`      | `24.0`                                                           | The minimum space between the toast left/right board and the view. |



This is everything you need for toast popups.


## 🐨 Author
This tiny library is created with ❤️ by [Joan Disho](https://twitter.com/_disho).

## 📃 License

`JDToaster` is released under an MIT license. See [License.md](https://github.com/jdisho/JDToaster/blob/master/LICENSE) for more information.








