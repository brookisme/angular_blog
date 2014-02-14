
AngularBlogApp.controller 'TagsController', ($scope,DataBridge,Tag) ->
  # setup
  ctrl = this
  ctrl.data = {}
  ctrl.bridge = DataBridge.bridge

  # vars 


  # init
  ctrl.init = () ->
    console.log("tags init")

  # rest methods
  ctrl.rest =
    index: ->
      params = {}
      Tag.query(params).$promise.then (tags) ->
        ctrl.data.tags = tags

    show: (tag_id)->
      Tag.get({id: tag_id}).$promise.then (tag) ->
        ctrl.data.tag = tag

    new: ()->
      ctrl.clear()
      ctrl.data.activeTag = {}
      ctrl.data.creating_new_tag = true

    create: ->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_tag = angular.copy(ctrl.data.activeTag)
        Tag.save(
          working_tag,
          (tag)->
            ctrl.data.tags ||= []
            ctrl.data.tags.push(tag)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("create_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )


    edit: (index,tag) ->
      ctrl.clear()
      ctrl.data.edit_index = index
      ctrl.data.activeTag = tag

    update: (index,tag)->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_tag = angular.extend(angular.copy(tag),ctrl.data.activeTag)
        Tag.update(
          working_tag,
          (tag)->
            ctrl.locked = false
          ,
          (error)->
            console.log("update_error:",error)
            ctrl.locked = false
        )
        ctrl.clear()

    delete: (index,tag,tags)->
      Tag.delete(
        tag, 
        (tag)->
          tags ||= ctrl.data.tags
          tags.splice(index,1)
        ,
        (error)->
          console.log("delete_error:",error)
      )
      ctrl.clear()


  # scope methods 
  ctrl.setTag = (tag)->
    ctrl.data.tag = tag

  ctrl.setTags = (tags)->
    ctrl.data.tags = tags

  ctrl.clear = ->
    ctrl.data.parent_id = null
    ctrl.data.activeTag = null
    ctrl.data.edit_index = null
    ctrl.data.creating_new_tag = false

  ctrl.isEditing = (index,parent_id)->
    (index == ctrl.data.edit_index) && (parent_id == ctrl.data.parent_id)

  # internal

  # return
  return