
dp = angular.module('ng-bs3-datepicker', [])

dp.directive 'ngBs3Datepicker', [ '$compile', '$timeout', ($compile, $timeout)->
  restrict: 'E'
  replace: true
  require: 'ngModel'

  template: """
    <div class='input-group date'>
      <input type='text' class='form-control'/>
      <span class='input-group-addon'>
        <span class='fa fa-calendar'></span>
      </span>
    </div>
  """

  link: ($scope, element, attr, ngModel)->
    $timeout ->
      dateFormat = ""

      attributes = element.prop "attributes"
      input = element.find "input"
      resetValue = false

      angular.forEach( attributes, (e)->
        unless e.name is "class"
          input.attr e.name, e.value
        if e.name is "date-format"
          dateFormat = e.value
      )
      
      # Format the initial value
      ngModel.$setViewValue( moment( ngModel.$modelValue ).format( dateFormat ) )

      $scope.$watch attr.language, (value)->
        language = if value then value else input.attr('language')
        input.datetimepicker(
          language: language
          pickTime: false
          format: dateFormat
          icons:
              time: 'fa fa-clock-o'
              date: 'fa fa-calendar'
              up: 'fa fa-arrow-up'
              down: 'fa fa-arrow-down'
        )

      #allow addon to be click in place of the input itself
      element.find('.input-group-addon').on 'click', (e)->
        element.find('input').focus()

      #update model from date picker change value
      element.on "change.dp",(e)->
        $scope.$apply ->
          if e.date
            objPath = attr.ngModel.split(".")
            obj = $scope
            for path,i in objPath
              obj[path] = {} unless obj[path]
              if i is objPath.length - 1
                if resetValue
                  resetValue = false
                  obj[path] = null
                else
                  obj[path] = e.date.format(dateFormat)
              else
                obj = obj[path]

      $scope.$watch attr.ngModel, (newValue, oldValue)->
        if(oldValue and !newValue) then resetValue = true

    $scope.$on '$destroy', ->
      if input.data('DateTimePicker')
        input.data('DateTimePicker').destroy()
      element.off 'change.dp'

      $compile(input)($scope)
  ]