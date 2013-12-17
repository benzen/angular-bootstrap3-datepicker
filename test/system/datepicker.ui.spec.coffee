
describe 'angular-bootstrap-datepicker', ->

  beforeEach ->
    browser().navigateTo('/example/demo.html')
    currentDate = new Date().toJSON().split("T")[0]
    @fifteenOfThisMonth = currentDate.substr(0, currentDate.length-2)+"15"

  it 'picking a date from the calendar table updates the scope', ->
    element('input#date1').query (elements, done)->
      elements.focus()
      done()

    jQueryFn('td.day:contains(15):first', 'click')

    expect(input('date1').val()).toEqual(@fifteenOfThisMonth)

  it 'can be updated by the scope', ->
    input('date2').enter(@fifteenOfThisMonth)
    expect(jQueryFn('input#date2', 'val')).toEqual(@fifteenOfThisMonth)
