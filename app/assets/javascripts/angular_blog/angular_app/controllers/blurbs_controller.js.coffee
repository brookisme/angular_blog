
AngularBlogApp.controller 'BlurbsController', ($scope,DataBridge,Blurb) ->
  # setup
  ctrl = this
  ctrl.data = {}
  ctrl.bridge = DataBridge.bridge

  # vars 
  ctrl.sizes = [
    "tiny",
    "small",
    "normal",
    "large",
    "huge",
  ]

  # init
  ctrl.init = (component) ->
    ctrl.data.blurb_component = component
    ctrl.setBlurb(component.postable)
    ctrl.rest.new() if !ctrl.data.blurb

  # rest methods
  ctrl.rest =
    index: ->
      params = {}
      Blurb.query(params).$promise.then (blurbs) ->
        ctrl.data.blurbs = blurbs

    show: (blurb_id)->
      Blurb.get({id: blurb_id}).$promise.then (blurb) ->
        ctrl.data.blurb = blurb

    new: ()->
      ctrl.clear()
      ctrl.data.activeBlurb = {}
      ctrl.data.blurb = ctrl.data.activeBlurb
      ctrl.data.creating_new_blurb = true

    create: ->
      if !(ctrl.locked || form_errors())
        ctrl.locked = true
        working_blurb = angular.copy(ctrl.data.activeBlurb)
        working_blurb.component_id = ctrl.data.blurb_component.id
        Blurb.save(
          working_blurb,
          (blurb)->
            ctrl.data.blurb_component.postable = blurb
            ctrl.setBlurb(blurb)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("create_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )


    edit: (blurb) ->
      ctrl.clear()
      ctrl.data.activeBlurb = blurb
      ctrl.activeCopy = angular.copy(ctrl.data.activeBlurb)

    update: ->
      if !(ctrl.locked || form_errors())
        ctrl.locked = true
        Blurb.update(
          ctrl.data.activeBlurb,
          (blurb)->
            ctrl.data.blurb_component.postable = blurb
            ctrl.setBlurb(blurb)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("update_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )
        ctrl.clear()

    delete: (blurb,create_new)->
      if !!blurb && !ctrl.locked
        Blurb.delete(
          blurb, 
          (blurb)->
            ctrl.data.blurb_component.postable = null
            ctrl.clear()
            ctrl.data.blurb = null
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
  ctrl.setBlurb = (blurb,activate)->
    ctrl.data.blurb = blurb

  ctrl.setBlurbs = (blurbs)->
    ctrl.data.blurbs = blurbs

  ctrl.reset = ->
    ctrl.data.activeBlurb = angular.extend(ctrl.data.activeBlurb,ctrl.activeCopy)
    ctrl.clear()

  ctrl.clear = ->
    ctrl.data.parent_id = null
    ctrl.data.activeBlurb = null
    ctrl.data.edit_index = null
    ctrl.data.creating_new_blurb = false

  ctrl.isEditing = ()->
    !!ctrl.data.activeBlurb && !!ctrl.data.activeBlurb.id

  # internal
  form_errors = ->
    ctrl.form.content.$error.required

  # return
  return
