
AngularBlogApp.controller 'CommentsController', ($scope,Comment) ->
  # setup
  ctrl = this
  ctrl.data = {}

  # vars 
  ctrl.data.comment_types = [
    "Header",
    "Blurb",
    "Image",
    "Video"
  ]

  # init
  ctrl.init = (post) ->
    ctrl.data.comment_post = post

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
      if !(ctrl.locked || ctrl.form.$error.required)
        ctrl.locked = true
        working_comment = angular.copy(ctrl.data.activeComment)
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
      if !(ctrl.locked || ctrl.form.$error.required)
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

  ctrl.showComments = (show=true)->
    console.log("SC",show)
    ctrl.data.showingComments = show

  ctrl.clear = ->
    ctrl.data.parent_id = null
    ctrl.data.activeComment = null
    ctrl.data.edit_index = null
    ctrl.data.creating_new_comment = false

  ctrl.isEditing = (index,parent_id)->
    (index == ctrl.data.edit_index) && (parent_id == ctrl.data.parent_id)

  # internal

  # return
  return