# Foodie Fast - Food Delivery App
## Introduction
Welcome to Foodie Fast, the swift and reliable food delivery app that brings your favorite meals right to your doorstep! Our app offers a wide range of culinary delights from local eateries and restaurants, ensuring there's something to satisfy every palate.

## Getting Started
To get started with Foodie Fast, clone this repository and import the project into your favorite IDE. Ensure you have the latest version of Android Studio for a smooth development experience.

## Android Build Configuration
For building the Android app, the Java version is crucial for compatibility:  

Minimum Java Version: Java 8  
Maximum Java Version: Java 17  
Ensure your development environment is set up with a compatible Java version to avoid any build issues.

## Usage
### Card payments
Currently the payment only support test payment as this app is a demo app.Use the following card number with any CVC and date exceed current date to implement payment.  
For more detail, please refer to this link [doc](https://stripe.com/docs/testing?testing-method=card-numbers#visa)


| NUMBER            | DESCRIPTION                                             |
|-------------------|---------------------------------------------------------|
| 4242424242424242  | Succeeds and immediately processes the payment.         |
| 4000002500003155  | Requires authentication. Stripe will trigger a modal asking for the customer to authenticate. |
| 4000000000009995  | Always fails with a decline code of insufficient_funds. |




## Contributing
We appreciate contributions from the community. If you wish to contribute, feel free to fork the repository, make your changes, and create a pull request.

## Support
For any support-related queries, please open an issue in the repository or contact our support team at <u>lohcy96@gmail.com</u>.
