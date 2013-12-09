describe 'ng-bootstrap3-datepicker', ()->

  beforeEach module 'ng-bootstrap3-datepicker'

  beforeEach inject ( _$rootScope_, _$compile_ )->
    @scope = _$rootScope_
    @compile = _$compile_
    @elm = angular.element """
      <label>Periode</label>
      <div class='form-group'>
        <datepicker data-ng-model='date' placeholder='AAAA-MM-JJ'/>
      </div>
    """
    @compile(@elm)(@scope)
    @scope.$digest()

  it 'should create textfield and group-add-on', ->

    expect( @elm.find('input').length ).toBe( 1 )
    expect( @elm.find('input')[0].type ).toEqual( "text" )
    expect( @elm.find(".input-group-addon").length ).toBe(1)

  it 'should copy all attribute of the element \'datepicker\' to the input element',->
    expect( @elm.find('input').attr("data-ng-model") ).toEqual("date")
    expect( @elm.find('input').attr("placeholder") ).toEqual( "AAAA-MM-JJ" )

  #XXX look for way to test this
  xit 'should focus on the input when clicking on the addon',->
    @elm.find('.input-group-addon').click()

    waitsFor( -> @elm.find('input').hasClass(':focus')
    'input to have the focus',
    10)

  it 'should show a date picker when the input has the focus',->
     @elm.find('input').click()
     expect( angular.element(".bootstrap-datetimepicker-widget .datepicker .datepicker-days").css("display")).toBe "block"

  it 'should update the model when updating the form by hand',->
     @elm.find('input').val("2013-01-01")

     # angular listen to the input event to update the model
     #see http://stackoverflow.com/questions/17109850/update-angular-model-after-setting-input-value-with-jquery?answertab=votes#tab-top
     @elm.find('input').trigger('input')

     expect(@scope.date).toEqual("2013-01-01")
     expect( angular.element(".bootstrap-datetimepicker-widget .datepicker .datepicker-days").css("display")).toBe "block"
