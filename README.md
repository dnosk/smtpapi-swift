# SMTPAPI-Swift

This Swift class allows you easily interact with and generate [SendGrid's SMTPAPI Header](https://sendgrid.com/docs/API_Reference/SMTP_API/index.html).

## Installation

There are a few ways to install this:

1. Clone the repo or download the SmtpApi.swift file. Then add the SmtpApi.swift file to your Xcode project.
2. Add this repo as a submodule in your project, and then copy the SmtpApi.swift file into your Xcode project.

## Usage

### Initializing

```swift
var header = SmtpApi()
```

### jsonValue

This property gives you the JSON string of your SmtpApi instance for use in the X-SMTPAPI header of your SMTP message or SendGrid's Web API.

```swift
header.jsonValue
// Example value: {"to":["isaac@example.none"]}
```

## Functions

#### addTo(address: String, name: String?)

Adds email address `address` to the list of recipients. Optionally a to name `name` can be passed.

```swift
var header = SmtpApi()
header.addTo("isaac@example.none", name: nil)
// JSON Value: {"to":["isaac@example.none"]}
header.addTo("jose@example.none", name: "jose")
// JSON Value: {"to":["isaac@example.none", "Jose <jose@example.none>"]}
```

#### addTos(addresses: [String], names: [String]?)

Appends an array of email addresses `addresses` to the list of recipients. Optionally a list of to name `names` can be passed.

```swift
var header = SmtpApi()
header.addTos(["isaac@example.none","jose@example.none"], names: nil)
// JSON Value: {"to":["isaac@example.none","jose@example.none"]}
header.addTos(["tim@example.none","joe@example.none"], names: ["Tim","Joe"])
// JSON Value: {"to":["isaac@example.none","jose@example.none","Tim <tim@example.none>","Joe <joe@example.none>"]}
```

#### setTos(addresses: [String], names: [String]?)

Resets the recipient list to the passed array of email addresses `addresses`. Optionally a list of to name `names` can be passed.

```swift
var header = SmtpApi()
header.setTos(["isaac@example.none","jose@example.none"], names: nil)
// JSON Value: {"to":["isaac@example.none","jose@example.none"]}
header.setTos(["tim@example.none","joe@example.none"], names: ["Tim","Joe"])
// JSON Value: {"to":["Tim <tim@example.none>","Joe <joe@example.none>"]}
```

#### addSubstitution(_:values:)

Adds an array of substitution `values` for a given `key`.

```swift
var header = SmtpApi()
header.addSubstitution("%name%", values: ["Isaac","Jose","Tim"])
// JSON Value: {"sub":{"%name%":["Isaac","Jose","Tim"]}}
header.setSubstitutions("%email%", value: ["isaac@example.none","jose@example.none","tim@example.none"])
// JSON Value: {"sub":{"%name%":["Isaac","Jose","Tim"],"%email%":["isaac@example.none","jose@example.none","tim@example.none"]}}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-fancy-new-feature`)
3. Commit your changes (`git commit -am 'Added fancy new feature'`)
4. Write tests for your changes and make sure all tests pass.
5. Push to the branch (`git push origin my-fancy-new-feature`)
6. Create a new Pull Request

## Running Tests

Run your tests inside Xcode (Product > Test)