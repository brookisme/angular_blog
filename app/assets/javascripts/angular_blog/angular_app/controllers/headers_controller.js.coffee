
AngularBlogApp.controller 'HeadersController', ($scope,Header) ->
  # setup
  ctrl = this
  ctrl.data = {}

  # vars 
  ctrl.data.sizes = [
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
      ctrl.data.creating_new_header = true

    create: ->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_header = angular.copy(ctrl.data.activeHeader)
        Header.save(
          working_header,
          (header)->
            ctrl.data.headers ||= []
            ctrl.data.headers.push(header)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("create_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )


    edit: (index,header) ->
      ctrl.clear()
      ctrl.data.edit_index = index
      ctrl.data.activeHeader = header

    update: (index,header)->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_header = angular.extend(angular.copy(header),ctrl.data.activeHeader)
        Header.update(
          working_header,
          (header)->
            ctrl.locked = false
          ,
          (error)->
            console.log("update_error:",error)
            ctrl.locked = false
        )
        ctrl.clear()

    delete: (index,header,headers)->
      Header.delete(
        header, 
        (header)->
          headers ||= ctrl.data.headers
          headers.splice(index,1)
        ,
        (error)->
          console.log("delete_error:",error)
      )
      ctrl.clear()


  # scope methods 
  ctrl.setHeader = (header)->
    ctrl.data.header = header

  ctrl.setHeaders = (headers)->
    ctrl.data.headers = headers

  ctrl.clear = ->
    ctrl.data.parent_id = null
    ctrl.data.activeHeader = null
    ctrl.data.edit_index = null
    ctrl.data.creating_new_header = false

  ctrl.isEditing = (index,parent_id)->
    (index == ctrl.data.edit_index) && (parent_id == ctrl.data.parent_id)

  # internal

  # return
  return