AngularBlogApp.controller 'ImagesController', ($scope,DataBridge,Image) ->
  # setup
  ctrl = this
  ctrl.data = {}
  ctrl.bridge = DataBridge.bridge

  # init
  ctrl.init = (component) ->
    ctrl.data.image_component = component
    ctrl.setImage(component.postable)
    ctrl.rest.new() if !ctrl.data.image

  # rest methods
  ctrl.rest =
    index: ->
      params = {}
      Image.query(params).$promise.then (images) ->
        ctrl.data.images = images

    show: (image_id)->
      Image.get({id: image_id}).$promise.then (image) ->
        ctrl.data.image = image

    new: ()->
      ctrl.clear()
      ctrl.data.activeImage = {}
      ctrl.data.image = ctrl.data.activeImage
      ctrl.data.creating_new_image = true

    create: ->
      if !(ctrl.locked || form_errors())
        ctrl.locked = true
        working_image = angular.copy(ctrl.data.activeImage)
        working_image.component_id = ctrl.data.image_component.id
        Image.save(
          working_image,
          (image)->
            ctrl.data.image_component.postable = image
            ctrl.setImage(image)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("create_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )


    edit: (image) ->
      ctrl.clear()
      ctrl.data.activeImage = image
      ctrl.activeCopy = angular.copy(ctrl.data.activeImage)

    update: ->
      if !(ctrl.locked || form_errors())
        ctrl.locked = true
        Image.update(
          ctrl.data.activeImage,
          (image)->
            ctrl.data.image_component.postable = image
            ctrl.setImage(image)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("update_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )
        ctrl.clear()

    delete: (image,create_new)->
      if !!image && !ctrl.locked
        Image.delete(
          image, 
          (image)->
            ctrl.data.image_component.postable = null
            ctrl.clear()
            ctrl.data.image = null
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
  ctrl.setImage = (image,activate)->
    ctrl.data.image = image

  ctrl.setImages = (images)->
    ctrl.data.images = images

  ctrl.showOptions = (show=true) ->
    ctrl.data.showing_options = show

  ctrl.reset = ->
    ctrl.data.activeImage = angular.extend(ctrl.data.activeImage,ctrl.activeCopy)
    ctrl.clear()

  ctrl.clear = ->
    ctrl.data.parent_id = null
    ctrl.data.activeImage = null
    ctrl.data.edit_index = null
    ctrl.data.creating_new_image = false

  ctrl.isEditing = ()->
    !!ctrl.data.activeImage && !!ctrl.data.activeImage.id

  # internal
  form_errors = ->
    ctrl.form.src.$error.required

  # return
  return