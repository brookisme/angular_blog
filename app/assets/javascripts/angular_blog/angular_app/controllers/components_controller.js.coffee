
AngularBlogApp.controller 'ComponentsController', ($scope,Component) ->
  # setup
  ctrl = this
  ctrl.data = {}

  # vars 
  ctrl.types = [
    "Header",
    "Blurb",
    "Image",
    "Video"
  ]

  # init
  ctrl.init = (post) ->
    ctrl.data.component_post = post
    ctrl.setComponents(post.components || [])

  # rest methods
  ctrl.rest =
    index: ->
      params = {}
      Component.query(params).$promise.then (components) ->
        ctrl.data.components = components

    show: (component_id)->
      Component.get({id: component_id}).$promise.then (component) ->
        ctrl.data.component = component

    new: ->
      ctrl.clear()
      ctrl.data.activeComponent = {}
      ctrl.data.creating_new_component = true

    create: (create_new)->
      if !(ctrl.locked)
        ctrl.locked = true
        working_component = angular.copy(ctrl.data.activeComponent)
        working_component.post_id = ctrl.data.component_post.id
        working_component.postable_type = postable_type(ctrl.data.activeComponent.type)
        Component.save(
          working_component,
          (component)->
            ctrl.data.component_post.components ||= []
            ctrl.data.component_post.components.push(component)
            ctrl.clear()
            ctrl.rest.new() if create_new
            ctrl.locked = false
          ,
          (error)->
            console.log("create_error:",error)
            ctrl.clear()
            ctrl.rest.new() if create_new
            ctrl.locked = false
        )


    edit: (index,component) ->
      ctrl.clear()
      ctrl.data.edit_index = index
      ctrl.data.activeComponent = component
      ctrl.activeCopy = angular.copy(ctrl.data.activeComponent)

    update: (index,create_new)->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_component = angular.copy(ctrl.data.activeComponent)
        working_component.postable_type = postable_type(ctrl.data.activeComponent.type)
        Component.update(
          working_component,
          (component)->
            ctrl.data.component_post.components ||= []
            ctrl.data.component_post.components.splice(index,1,component)
            ctrl.rest.new() if create_new
            ctrl.locked = false
          ,
          (error)->
            console.log("update_error:",error)
            ctrl.rest.new() if create_new
            ctrl.locked = false
        )
        ctrl.clear()

    delete: (index,component,create_new)->
      if !ctrl.locked
        Component.delete(
          component, 
          (component)->
            ctrl.data.components ||= []
            ctrl.data.components.splice(index,1)
            ctrl.clear()
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
  ctrl.setComponent = (component)->
    ctrl.data.component = component

  ctrl.setComponents = (components)->
    ctrl.data.components = components

  ctrl.showOptions = (show=true) ->
    ctrl.data.showing_options = show

  ctrl.reset = ->
    ctrl.data.activeComponent = angular.extend(ctrl.data.activeComponent,ctrl.activeCopy)
    ctrl.clear()

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

  ctrl.isEditing = (component_id)->
    !ctrl.data.creating_new_component && !!ctrl.data.activeComponent && ctrl.data.activeComponent.id == component_id

  # internal
  postable_type = (type)->
    "AngularBlog::" + type

  # return
  return