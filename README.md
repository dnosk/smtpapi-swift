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
header.addSubstitution("%email%", values: ["isaac@example.none","jose@example.none","tim@example.none"])
// JSON Value: {"sub":{"%name%":["Isaac","Jose","Tim"],"%email%":["isaac@example.none","jose@example.none","tim@example.none"]}}
```

#### addSection(_:value:)

Adds a new section tag. See the [Sections documentation](https://sendgrid.com/docs/API_Reference/SMTP_API/section_tags.html) for more info (this is generally used in conjunction with substitution tags).

```swift
var header = SmtpApi()
header.addSection("-greetMale-", value: "Hello Mr. %name%")
// JSON Value: {"section":{"-greetMale-":"Hello Mr. %name%"}}
header.addSection("-greetFemale-", value: "Hello Ms. %name%")
// JSON Value: {"section":{"-greetMale-":"Hello Mr. %name%","-greetFemale-":"Hello Ms. %name%"}}
```

#### addUniqueArgument(_:value:)

Adds a [Unique Argument](https://sendgrid.com/docs/API_Reference/SMTP_API/unique_arguments.html) to the header.

```swift
var header = SmtpApi()
header.addUniqueArgument("foo", value: "bar")
// JSON Value: {"unique_args":{"foo":"bar"}}
```

#### addCategory(_:)

Adds a category to the header.

```swift
var header = SmtpApi()
header.addCategory("Transactional")
// JSON Value: {"category":["Transactional"]}
header.addCategory("Forgot Password")
// JSON Value: {"category":["Transactional","Forgot Password"]}
```

#### addCategories(_:)

Adds an array of categories to the header.

```swift
var header = SmtpApi()
header.addCategories(["Transactional", "Forgot Password"])
// JSON Value: {"category":["Transactional","Forgot Password"]}
```

#### addFilter(_:setting:value:)

Adds settings for a specified [App](https://sendgrid.com/docs/API_Reference/SMTP_API/apps.html). The first parameter is the name of the app to edit, and uses the SendGridFilter enum defined at the top of SmtpApi.swift to avoid common mistakes.

```swift
var header = SmtpApi()
header.addFilter(SendGridFilter.OpenTracking, setting: "enable", value: 0)
// JSON Value: {"filters":{"opentrack":{"settings":{"enable":0}}}}
```

#### setSendAt(_:)

Sets a date (NSDate) to send the message at. Keep in mind that you can only schedule up to 24 hours in the future.

```swift
var header = SmtpApi()
var date = NSDate(timeIntervalSinceNow: (3 * 60 * 60)) // 3 hours from now
header.setSendAt(date)
// Example JSON Value: {"send_at":1407974400)}
```

#### setSendEachAt(_:)

Sets a list of dates that corresponds with the `to` array for when to send each message.

```swift
var header = SmtpApi()
var date1 = NSDate(timeIntervalSinceNow: (2 * 60 * 60))
var date2 = NSDate(timeIntervalSinceNow: (5 * 60 * 60))
header.setSendEachAt([date1, date2])
// Example JSON Value: {"send_each_at":[1407974400,1407974815]}
```

#### setAsmGroup(_:)

Sets an [Advanced Suppression Management Group](https://sendgrid.com/docs/User_Guide/advanced_suppression_manager.html) for the message.

```swift
var header = SmtpApi()
header.setAsmGroup(2)
// JSON Value: {"asm_group_id":2}
```

#### setIpPool(_:)

Specifies an IP Pool to send the message over. For information on setting up an IP Pool, view the [Documentation page](https://sendgrid.com/docs/API_Reference/Web_API_v3/IP_Management/ip_pools.html).

```swift
var header = SmtpApi()
header.setIpPool("pool_party")
// JSON Value: {"ip_pool":"pool_party"}
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