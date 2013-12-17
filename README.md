# angular-bootstrap3-datepicker
A [AngularJS](http://angularjs.org/) directives for the [bootstrap3-datepicker](https://github.com/Eonasdan/bootstrap-datetimepicker)

## Demo

Here's a working [jsfiddle](http://jsfiddle.net/benzen/46E2E/)
Look [here](https://github.com/Eonasdan/bootstrap-datetimepicker) for more information about the original jquery-plugin and more demo.

## Installation

Installation is easy, jQuery, momentjs, AngularJS and Bootstrap's JS/CSS are required.
You can download angular-bootstrap-datepicker via bower:
`bower install angular-bootstrap3-datepicker`

When you are done downloading all the dependencies and project files the only remaining part is to add dependencies as an AngularJS module:

```javascript
angular.module('myModule', ['ng-bootstrap3-datepicker']);
```

You also need to include these files:
```html
<link rel="stylesheet" href="bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="angular-bootstrap-datepicker.css" />

<script src="jquery.js"></script>
<script src="bootstrap/js/bootstrap.js"></script>
<script src="angular.js"></script>
<script src="moment.js"></script>
<script src="moment-your-locale.js"></script>
<script src="angular-bootstrap3-datepicker.js" charset="utf-8"></script>
```

Make sure you use `charset="utf-8"` in your script tag if your browser (or those of your users) is displaying characters wrong when using another language.

## Settings

To use the directive, use the following code :

```html
<datepicker ng-model="date" language="en" date-format="YYYY-MM-DD">
```

`datepicker` : Indicates you want a date picker

`language` : The locale you want to use for this date picker. To work, this require adding the corresponding momentjs locale file.

`ng-model` : Variable of the controller scope to store the date. The date is currently store as a string, formatted according to date format.

`date-format`: Format to use to format the date. The correct definition can be found [here](http://momentjs.com/docs/#/displaying/format/)

For a working example, see http://jsfiddle.net/benzen/46E2E/

# Thanks to

 * cletourneau: https://github.com/cletourneau
 * Eonasdan: https://github.com/Eonasdan/bootstrap-datetimepicker
