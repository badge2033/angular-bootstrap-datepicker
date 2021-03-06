dp = angular.module('ng-bootstrap-datepicker', [])

dp.directive 'ngDatepicker', ->
  restrict: 'A'
  replace: true
  scope:
    ngDatePickerOptions: '='
    ngModel: '='
  template: """
            <div class="input-group date">
              <input type="text" class="form-control">
              <span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
            </div>
            """
  link: (scope, element)->
    scope.inputHasFocus = false

    element.datepicker(scope.ngDatePickerOptions).on('changeDate', (e)->

      defaultFormat = $.fn.datepicker.defaults.format
      format = scope.ngDatePickerOptions.format || defaultFormat
      defaultLanguage = $.fn.datepicker.defaults.language
      language = scope.ngDatePickerOptions.language || defaultLanguage

      scope.$apply -> scope.ngModel = $.fn.datepicker.DPGlobal.formatDate(e.date, format, language)
    )

    element.find('input').on('focus', ->
      scope.inputHasFocus = true
    ).on('blur', ->
      scope.inputHasFocus = false
    )

    scope.$watch 'ngModel', (newValue)->
      if not scope.inputHasFocus
        element.datepicker('update', newValue)
