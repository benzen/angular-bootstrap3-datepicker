
dp = angular.module('ng-bootstrap3-datepicker', [])

dp.directive 'datepicker', ($compile)->

  dateFormat = ""
  language = ""

  restrict: 'E'
  replace: true
  template: """
    <div class='input-group date'>
      <input type='text' class='form-control' data-format="#{dateFormat}"/>
      <span class='input-group-addon'>
        <span class='fa fa-calendar'></span>
      </span>
    </div>
  """

  link: ($scope, element, attr)->

    attributes = element.prop "attributes"
    input = element.find "input"

    angular.forEach( attributes, (e)->
      unless e.name is "class"
        input.attr e.name, e.value
      if e.name is "date-format"
        dateFormat = e.value
      if e.name is "language"
        language = e.value
    )

    input.datetimepicker(
      language: language
      pickTime: false
      icons:
          time: 'fa fa-clock-o'
          date: 'fa fa-calendar'
          up: 'fa fa-arrow-up'
          down: 'fa fa-arrow-down'
    )

    element.find('.input-group-addon').on 'click', (e)->
      element.find('input').focus()

    #update model from date picker change value
    element.on "change.dp",(e)->

      if e.date
        objPath = attr.ngModel.split(".")
        obj = $scope
        for path,i in objPath
          obj[path] = {} unless obj[path]
          obj[path] = e.date.format(dateFormat) if i is objPath.length - 1
          obj = obj[path]

        $scope.$digest()

    $compile(input)($scope)
