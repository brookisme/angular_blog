
AngularBlogApp.controller 'HeadersController', ($scope,Header) ->
  # setup
  ctrl = this
  ctrl.data = {}

  # vars 
  ctrl.sizes = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6"
  ]

  # init
  ctrl.init = (component) ->
    ctrl.data.header_component = component
    ctrl.setHeader(component.postable)
    ctrl.rest.new() if !ctrl.data.header

  # rest methods
  ctrl.rest =
    index: ->
      params = {}
      Header.query(params).$promise.then (headers) ->
        ctrl.data.headers = headers

    show: (header_id)->
      Header.get({id: header_id}).$promise.then (header) ->
        ctrl.data.header = header

    new: ()->
      ctrl.clear()
      ctrl.data.activeHeader = {}
      ctrl.data.header = ctrl.data.activeHeader
      ctrl.data.creating_new_header = true

    create: ->
      if !(ctrl.locked || form_errors())
        ctrl.locked = true
        working_header = angular.copy(ctrl.data.activeHeader)
        working_header.component_id = ctrl.data.header_component.id
        Header.save(
          working_header,
          (header)->
            ctrl.data.header_component.postable = header
            ctrl.setHeader(header)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("create_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )


    edit: (header) ->
      ctrl.clear()
      ctrl.data.activeHeader = header
      ctrl.activeCopy = angular.copy(ctrl.data.activeHeader)

    update: ->
      if !(ctrl.locked || form_errors())
        ctrl.locked = true
        Header.update(
          ctrl.data.activeHeader,
          (header)->
            ctrl.data.header_component.postable = header
            ctrl.setHeader(header)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("update_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )
        ctrl.clear()

    delete: (header,create_new)->
      if !!header && !ctrl.locked
        Header.delete(
          header, 
          (header)->
            ctrl.data.header_component.postable = null
            ctrl.clear()
            ctrl.data.header = null
            ctrl.rest.new() if create_new
            ctrl.locked = false
          ,
          (error)->
            console.log("delete_error:",error)
            ctrl.clear()
            ctrl.rest.new() if create_new
            ctrl.locked = false
        )


  # scope methods 
  ctrl.setHeader = (header,activate)->
    ctrl.data.header = header

  ctrl.setHeaders = (headers)->
    ctrl.data.headers = headers

  ctrl.reset = ->
    ctrl.data.activeHeader = angular.extend(ctrl.data.activeHeader,ctrl.activeCopy)
    ctrl.clear()

  ctrl.clear = ->
    ctrl.data.parent_id = null
    ctrl.data.activeHeader = null
    ctrl.data.edit_index = null
    ctrl.data.creating_new_header = false

  ctrl.isEditing = ()->
    !!ctrl.data.activeHeader && !!ctrl.data.activeHeader.id

  # internal
  form_errors = ->
    ctrl.form.content.$error.required

  # return
  return