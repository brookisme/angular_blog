
AngularBlogApp.controller 'ImagesController', ($scope,Image) ->
  # setup
  ctrl = this
  ctrl.data = {}

  # vars 


  # init
  ctrl.init = (component) ->
    ctrl.data.image_component = component

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
      ctrl.data.creating_new_image = true

    create: ->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_image = angular.copy(ctrl.data.activeImage)
        Image.save(
          working_image,
          (image)->
            ctrl.data.images ||= []
            ctrl.data.images.push(image)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("create_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )


    edit: (index,image) ->
      ctrl.clear()
      ctrl.data.edit_index = index
      ctrl.data.activeImage = image

    update: (index,image)->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_image = angular.extend(angular.copy(image),ctrl.data.activeImage)
        Image.update(
          working_image,
          (image)->
            ctrl.locked = false
          ,
          (error)->
            console.log("update_error:",error)
            ctrl.locked = false
        )
        ctrl.clear()

    delete: (index,image,images)->
      Image.delete(
        image, 
        (image)->
          images ||= ctrl.data.images
          images.splice(index,1)
        ,
        (error)->
          console.log("delete_error:",error)
      )
      ctrl.clear()


  # scope methods 
  ctrl.setImage = (image)->
    ctrl.data.image = image

  ctrl.setImages = (images)->
    ctrl.data.images = images

  ctrl.clear = ->
    ctrl.data.parent_id = null
    ctrl.data.activeImage = null
    ctrl.data.edit_index = null
    ctrl.data.creating_new_image = false

  ctrl.isEditing = (index,parent_id)->
    (index == ctrl.data.edit_index) && (parent_id == ctrl.data.parent_id)

  # internal

  # return
  return