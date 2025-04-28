This project was built for the tutorial [[Fun with LLMs: Building a Haiku Maker App with a Vision Model](This project was built for the tutorial [Fun with LLMs: Building a Haiku Maker App with a Vision Model])]

![Demo](https://raw.githubusercontent.com/DzeDze/HaiKuMaking/refs/heads/main/demo.gif?raw=true)

# ARCHITECTURE

![Demo](https://raw.githubusercontent.com/DzeDze/HaiKuMaking/refs/heads/main/architecture.png)

For the API layer, we’ll define a ```HaikuGenerator``` protocol to allow easy swapping between different implementations and make testing easier using ```Dependency Injection```.
We’ll mainly use SwiftUI for the UI because it’s quick and straightforward to set up.
For the image picker, we’ll use ```PHPickerViewController``` instead of ```UIImagePickerController```. Since we only need to select an image (no need for editing or capturing new ones), ```PHPickerViewController``` is lighter and easier to configure.
Because ```PHPickerViewController``` is a ```UIKit``` component, we’ll integrate it into SwiftUI using ```UIViewControllerRepresentable```.