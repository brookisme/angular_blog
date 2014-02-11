
AngularBlogApp.controller 'ComponentsController', ($scope,Component) ->
  # setup
  ctrl = this
  ctrl.data = {}

  # vars 
  ctrl.data.postable_types = [
    "Header",
    "Blurb",
    "Image",
    "Video"
  ]

  # init
  ctrl.init = (post) ->
    ctrl.data.component_post = post
    ctrl.setComponents(post.components || [])
    console.log("POST",post,post.components)

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
      if !(ctrl.locked)
        ctrl.locked = true
        working_component = angular.copy(ctrl.data.activeComponent)
        working_component.post_id = ctrl.data.component_post.id
        Component.save(
          working_component,
          (component)->
            ctrl.data.component_post.components ||= []
            ctrl.data.component_post.components.push(component)
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

  ctrl.showOptions = (show=true) ->
    ctrl.data.showing_options = show

  ctrl.clear = ->
    ctrl.data.parent_id = null
    ctrl.data.activeComponent = null
    ctrl.data.edit_index = null
    ctrl.data.creating_new_component = false
    ctrl.data.showing_options = false

  ctrl.isHeader = (type)->
    type == "header"
  
  ctrl.isBlurb = (type)->
    type == "blurb"

  ctrl.isEditing = (index,parent_id)->
    (index == ctrl.data.edit_index) && (parent_id == ctrl.data.parent_id)

  # internal

  # return
  return