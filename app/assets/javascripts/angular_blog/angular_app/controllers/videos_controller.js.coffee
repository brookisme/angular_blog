
AngularBlogApp.controller 'VideosController', ($scope,Video) ->
  # setup
  ctrl = this
  ctrl.data = {}

  # vars 


  # init
  ctrl.init = () ->
    console.log("videos init")

  # rest methods
  ctrl.rest =
    index: ->
      params = {}
      Video.query(params).$promise.then (videos) ->
        ctrl.data.videos = videos

    show: (video_id)->
      Video.get({id: video_id}).$promise.then (video) ->
        ctrl.data.video = video

    new: ()->
      ctrl.clear()
      ctrl.data.activeVideo = {}
      ctrl.data.creating_new_video = true

    create: ->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_video = angular.copy(ctrl.data.activeVideo)
        Video.save(
          working_video,
          (video)->
            ctrl.data.videos ||= []
            ctrl.data.videos.push(video)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("create_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )


    edit: (index,video) ->
      ctrl.clear()
      ctrl.data.edit_index = index
      ctrl.data.activeVideo = video

    update: (index,video)->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_video = angular.extend(angular.copy(video),ctrl.data.activeVideo)
        Video.update(
          working_video,
          (video)->
            ctrl.locked = false
          ,
          (error)->
            console.log("update_error:",error)
            ctrl.locked = false
        )
        ctrl.clear()

    delete: (index,video,videos)->
      Video.delete(
        video, 
        (video)->
          videos ||= ctrl.data.videos
          videos.splice(index,1)
        ,
        (error)->
          console.log("delete_error:",error)
      )
      ctrl.clear()


  # scope methods 
  ctrl.setVideo = (video)->
    ctrl.data.video = video

  ctrl.setVideos = (videos)->
    ctrl.data.videos = videos

  ctrl.clear = ->
    ctrl.data.parent_id = null
    ctrl.data.activeVideo = null
    ctrl.data.edit_index = null
    ctrl.data.creating_new_video = false

  ctrl.isEditing = (index,parent_id)->
    (index == ctrl.data.edit_index) && (parent_id == ctrl.data.parent_id)

  # internal

  # return
  return