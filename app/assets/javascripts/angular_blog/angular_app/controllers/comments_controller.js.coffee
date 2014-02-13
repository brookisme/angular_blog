
AngularBlogApp.controller 'CommentsController', ($scope,Comment) ->
  # setup
  ctrl = this
  ctrl.data = {}
  ctrl.data.comments = []

  # vars 
  ctrl.data.comment_types = [
    "Header",
    "Blurb",
    "Image",
    "Video"
  ]

  # init
  ctrl.init = (post) ->
    if !!post
      ctrl.data.comment_post = post
      ctrl.setComments(post.comments)

  # rest methods
  ctrl.rest =
    index: ->
      params = {}
      Comment.query(params).$promise.then (comments) ->
        ctrl.data.comments = comments

    show: (comment_id)->
      Comment.get({id: comment_id}).$promise.then (comment) ->
        ctrl.data.comment = comment

    new: ()->
      ctrl.clear()
      ctrl.data.activeComment = {}
      ctrl.data.creating_new_comment = true

    create: ->
      if !(ctrl.locked || form_errors())
        ctrl.locked = true
        working_comment = angular.copy(ctrl.data.activeComment)
        working_comment.post_id = ctrl.data.comment_post.id
        Comment.save(
          working_comment,
          (comment)->
            ctrl.data.comments ||= []
            ctrl.data.comments.push(comment)
            ctrl.clear()
            ctrl.locked = false
          ,
          (error)->
            console.log("create_error:",error)
            ctrl.clear()
            ctrl.locked = false
        )


    edit: (index,comment) ->
      ctrl.clear()
      ctrl.data.edit_index = index
      ctrl.data.activeComment = comment

    update: (index,comment)->
      if !(ctrl.locked || form_errors())
        ctrl.locked = true
        working_comment = angular.extend(angular.copy(comment),ctrl.data.activeComment)
        Comment.update(
          working_comment,
          (comment)->
            ctrl.locked = false
          ,
          (error)->
            console.log("update_error:",error)
            ctrl.locked = false
        )
        ctrl.clear()

    delete: (index,comment,comments)->
      Comment.delete(
        comment, 
        (comment)->
          comments ||= ctrl.data.comments
          comments.splice(index,1)
        ,
        (error)->
          console.log("delete_error:",error)
      )
      ctrl.clear()


  # scope methods 
  ctrl.setComment = (comment)->
    ctrl.data.comment = comment

  ctrl.setComments = (comments)->
    ctrl.data.comments = comments

  ctrl.acceptComments = ->
    ctrl.data.comment_post.accept_comments
  
  ctrl.commentsClosed = ->
    ctrl.data.comment_post.comments_closed

  ctrl.numComments = ->
    ctrl.data.comments.length

  ctrl.hasComments = ->
    ctrl.numComments() > 0

  ctrl.showComments = (show=true)->
    ctrl.data.showingComments = show

  ctrl.clear = ->
    ctrl.data.activeComment = null
    ctrl.data.edit_index = null
    ctrl.data.creating_new_comment = false

  ctrl.isEditing = (index,post_id)->
    (index == ctrl.data.edit_index) && (post_id == ctrl.data.comment_post.id)
  
  # internal
  form_errors = ->
    ctrl.form.email.$error.required || ctrl.form.email.$error.email || ctrl.form.content.$error.required || ctrl.form.content.$error.minlength 

  # return
  return