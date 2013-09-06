describe "Rahani.Views.SortingRules.Form", ->
  createView = (model = new Rahani.Models.SortingRule())->
    categories = new Rahani.Collections.Categories [
      {
        id: 11
        name: 'Category One'
        type: 'Essential'
      }
      {
        id: 22
        name: 'Category Two'
        type: 'Flexible'
      }
      {
        id: 33
        name: 'Category Three'
        type: 'Income'
      }
      {
        id: 44
        name: 'Transfer In'
        type: 'Transfer'
      }
    ]
    view = new Rahani.Views.SortingRules.Form
      model: model
      categories: categories
    view

  it "should be defined", ->
    expect(Rahani.Views.SortingRules.Form).toBeDefined()

  it "should use the correct template", ->
    expect(Rahani.Views.SortingRules.Form).toUseTemplate('sorting_rules/form')

  it "can be rendered", ->
    view = createView()
    expect(view.render).not.toThrow()

  it "renders the form fields", ->
    view = createView().render()
    expect(view.$el).toContain('input[name=name]')
    expect(view.$el).toContain('input[name=contains]')
    expect(view.$el).toContain('select[name=category]')
    expect(view.$el).toContain('option[value=11]')
    expect(view.$el).toContain('option[value=22]')
    expect(view.$el).toContain('option[value=33]')
    expect(view.$el).toContain('option[value=44]')
    expect(view.$el).toContain('optgroup[label=Essential]')
    expect(view.$el).toContain('optgroup[label=Flexible]')
    expect(view.$el).toContain('optgroup[label=Income]')
    expect(view.$el).toContain('optgroup[label=Transfer]')

  it "renders the heading for new sorting_rule", ->
    view = createView().render()
    expect(view.$el).toHaveText(/New Sorting Rule/)

  it "renders the heading for existing sorting_rule", ->
    model = new Rahani.Models.SortingRule
      name: 'Some SortingRule'
    view = createView(model).render()
    expect(view.$el).toHaveText(/Some SortingRule/)

  it "renders the cancel link", ->
    view = createView().render()
    expect(view.$el).toContain('a[href="/sorting-rules"]')


  it "should set the values on the model when update is called", ->
    model = new Rahani.Models.SortingRule()
    view = createView(model).render()

    view.$el.find('input[name=name]').val('New Name')
    view.$el.find('input[name=contains]').val('Old Name')
    view.$el.find('select[name=category]').val('11')

    spyOn(model, 'set')

    view.update()

    expect(model.set).toHaveBeenCalledWith
      name: 'New Name'
      contains: 'Old Name'
      category_id: '11'

  it "renders the form fields with the model values", ->
    model = new Rahani.Models.SortingRule
      name: 'Foobar'
      contains: 'Barfoo'
      category_id: '22'

    view = createView(model).render()

    expect(view.$el.find('input[name=name]')).toHaveValue('Foobar')
    expect(view.$el.find('input[name=contains]')).toHaveValue('Barfoo')
    expect(view.$el.find('select[name=category]')).toHaveValue('22')
