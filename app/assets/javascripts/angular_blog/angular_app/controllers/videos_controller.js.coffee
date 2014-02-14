AngularBlogApp.controller 'VideosController', ($scope,DataBridge,Video,Youtube) ->
  # setup
  ctrl = this
  ctrl.data = {}
  ctrl.youtube = Youtube
  ctrl.bridge = DataBridge.bridge

  # vars 
  ctrl.hosts = [
    "youtube",
    "vimeo"
  ]

  # init
  ctrl.init = (component) ->
    ctrl.data.video_component = component
    ctrl.setVideo(component.postable)
    ctrl.rest.new() if !ctrl.data.video

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
      ctrl.data.video = ctrl.data.activeVideo
      ctrl.data.creating_new_video = true

    create: ->
      if !(ctrl.locked || form_errors())
        ctrl.locked = true
        working_video = angular.copy(ctrl.data.activeVideo)
        working_video.component_id = ctrl.data.video_component.id
        Video.save(
          working_video,
          (video)->
            ctrl.data.video_component.postable = video
            ctrl.setVideo(video)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("create_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )


    edit: (video) ->
      ctrl.clear()
      ctrl.data.activeVideo = video
      ctrl.activeCopy = angular.copy(ctrl.data.activeVideo)

    update: ->
      if !(ctrl.locked || form_errors())
        ctrl.locked = true
        Video.update(
          ctrl.data.activeVideo,
          (video)->
            ctrl.data.video_component.postable = video
            ctrl.setVideo(video)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("update_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )
        ctrl.clear()

    delete: (video,create_new)->
      if !!video && !ctrl.locked
        Video.delete(
          video, 
          (video)->
            ctrl.data.video_component.postable = null
            ctrl.clear()
            ctrl.data.video = null
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
  ctrl.setVideo = (video,activate)->
    ctrl.data.video = video

  ctrl.setVideos = (videos)->
    ctrl.data.videos = videos

  ctrl.reset = ->
    ctrl.data.activeVideo = angular.extend(ctrl.data.activeVideo,ctrl.activeCopy)
    ctrl.clear()

  ctrl.clear = ->
    ctrl.data.parent_id = null
    ctrl.data.activeVideo = null
    ctrl.data.edit_index = null
    ctrl.data.creating_new_video = false

  ctrl.isEditing = ()->
    !!ctrl.data.activeVideo && !!ctrl.data.activeVideo.id

  # internal
  form_errors = ->
    ctrl.form.identifier.$error.required || ctrl.form.host.$error.required

  # return
  return