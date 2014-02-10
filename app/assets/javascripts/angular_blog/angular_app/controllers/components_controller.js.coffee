
AngularBlogApp.controller 'ComponentsController', ($scope,Component) ->
  # setup
  ctrl = this
  ctrl.data = {}

  # vars 
  ctrl.data.component_types = [
    "Header",
    "Blurb",
    "Image",
    "Video"
  ]

  # init
  ctrl.init = (post) ->
    ctrl.data.component_post = post

  # rest methods
  ctrl.rest =
    index: ->
      params = {}
      Component.query(params).$promise.then (components) ->
        ctrl.data.components = components

    show: (component_id)->
      Component.get({id: component_id}).$promise.then (component) ->
        ctrl.data.component = component

    new: ()->
      ctrl.clear()
      ctrl.data.activeComponent = {}
      ctrl.data.creating_new_component = true

    create: ->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_component = angular.copy(ctrl.data.activeComponent)
        Component.save(
          working_component,
          (component)->
            ctrl.data.components ||= []
            ctrl.data.components.push(component)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("create_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )


    edit: (index,component) ->
      ctrl.clear()
      ctrl.data.edit_index = index
      ctrl.data.activeComponent = component

    update: (index,component)->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_component = angular.extend(angular.copy(component),ctrl.data.activeComponent)
        Component.update(
          working_component,
          (component)->
            ctrl.locked = false
          ,
          (error)->
            console.log("update_error:",error)
            ctrl.locked = false
        )
        ctrl.clear()

    delete: (index,component,components)->
      Component.delete(
        component, 
        (component)->
          components ||= ctrl.data.components
          components.splice(index,1)
        ,
        (error)->
          console.log("delete_error:",error)
      )
      ctrl.clear()


  # scope methods 
  ctrl.setComponent = (component)->
    ctrl.data.component = component

  ctrl.setComponents = (components)->
    ctrl.data.components = components

  ctrl.clear = ->
    ctrl.data.parent_id = null
    ctrl.data.activeComponent = null
    ctrl.data.edit_index = null
    ctrl.data.creating_new_component = false

  ctrl.isHeader = (type)->
    type == "header"
  
  ctrl.isBlurb = (type)->
    type == "blurb"

  ctrl.isEditing = (index,parent_id)->
    (index == ctrl.data.edit_index) && (parent_id == ctrl.data.parent_id)

  # internal

  # return
  return