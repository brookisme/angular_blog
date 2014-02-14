
AngularBlogApp.controller 'BlurbsController', ($scope,DataBridge,Blurb) ->
  # setup
  ctrl = this
  ctrl.data = {}
  ctrl.bridge = DataBridge.bridge
  
  # vars 
  ctrl.data.sizes = [
    "tiny",
    "small",
    "normal",
    "large",
    "huge",
  ]

  # init
  ctrl.init = (component) ->
    ctrl.data.blurb_component = component

  # rest methods
  ctrl.rest =
    index: ->
      params = {}
      Blurb.query(params).$promise.then (blurbs) ->
        ctrl.data.blurbs = blurbs

    show: (blurb_id)->
      Blurb.get({id: blurb_id}).$promise.then (blurb) ->
        ctrl.data.header = header

    new: ()->
      ctrl.clear()
      ctrl.data.activeBlurb = {}
      ctrl.data.creating_new_header = true

    create: ->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_header = angular.copy(ctrl.data.activeBlurb)
        Blurb.save(
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
      ctrl.data.activeBlurb = header

    update: (index,header)->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_header = angular.extend(angular.copy(header),ctrl.data.activeBlurb)
        Blurb.update(
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
      Blurb.delete(
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
  ctrl.setBlurb = (header)->
    ctrl.data.header = header

  ctrl.setBlurbs = (headers)->
    ctrl.data.headers = headers

  ctrl.clear = ->
    ctrl.data.parent_id = null
    ctrl.data.activeBlurb = null
    ctrl.data.edit_index = null
    ctrl.data.creating_new_header = false

  ctrl.isEditing = (index,parent_id)->
    (index == ctrl.data.edit_index) && (parent_id == ctrl.data.parent_id)

  # internal

  # return
  return