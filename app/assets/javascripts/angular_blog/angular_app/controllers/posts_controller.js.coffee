
AngularBlogApp.controller 'PostsController', ($scope,DataBridge,Post,AddthisManager) ->
  # setup
  ctrl = this
  ctrl.data = {}
  ctrl.bridge = DataBridge.bridge
  ctrl.preview = {}
  ctrl.addthis = AddthisManager

  # vars 


  # init
  # ctrl.init = () -> TODO

  # rest methods
  ctrl.rest =
    index: ->
      params = {}
      Post.query(params).$promise.then (posts) ->
        ctrl.data.posts = posts

    show: (post_id)->
      Post.get({id: post_id}).$promise.then (post) ->
        ctrl.data.post = post

    new: ()->
      ctrl.clear()
      ctrl.data.activePost = { display_subject: true, accept_comments: true }
      ctrl.data.creating_new_post = true

    create: ->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_post = angular.copy(ctrl.data.activePost)
        working_post.blogger_id = ctrl.bridge.blogger.id
        Post.save(
          working_post,
          (post)->
            post = setDate(post)
            ctrl.data.posts ||= []
            ctrl.data.posts.splice(0,0,post)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("create_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )


    edit: (index,post) ->
      ctrl.clear()
      ctrl.data.edit_index = index
      ctrl.data.activePost = post

    update: (index,post)->
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_post = angular.extend(angular.copy(post),ctrl.data.activePost)
        Post.update(
          working_post,
          (post)->
            post = setDate(post)
            ctrl.data.posts ||= []
            ctrl.data.posts.splice(index,1,post)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("update_error:",error)
            ctrl.locked = false
        )
        ctrl.clear()

    delete: (index,post,posts)->
      Post.delete(
        post, 
        (post)->
          posts ||= ctrl.data.posts
          posts.splice(index,1)
        ,
        (error)->
          console.log("delete_error:",error)
      )
      ctrl.clear()


  # scope methods 
  ctrl.setPost = (post)->
    ctrl.data.post = post

  ctrl.setPosts = (posts)->
    ctrl.data.posts = posts

  ctrl.newComponent = ->
    ctrl.data.adding_component = true

  ctrl.clear = ->
    ctrl.data.parent_id = null
    ctrl.data.activePost = null
    ctrl.data.edit_index = null
    ctrl.data.adding_component = false
    ctrl.data.creating_new_post = false

  ctrl.togglePreview = (index)->
    ctrl.preview[index] = !ctrl.preview[index]

  ctrl.isEditing = (index,post_id)->
    if !!ctrl.data.activePost
      (index == ctrl.data.edit_index) && (post_id == ctrl.data.activePost.id)

  # internal

  setDate = (post)->
    if !post.published 
      post.timestamp = null
    else if !post.published_on
      post.timestamp = (new Date()).toLocaleString()
    post

  # return
  return