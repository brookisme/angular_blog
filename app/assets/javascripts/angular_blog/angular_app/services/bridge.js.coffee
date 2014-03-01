AngularBlogApp.factory "DataBridge", ->
  bridge: {
    edit_mode: false
    blogger_id: null
    blogger_is_super: false
    toggleEditMode: ->
      this.edit_mode = !this.edit_mode
    setBlogger: (blogger)->
      if !!blogger
        this.blogger = blogger
        this.blogger_id = blogger.id
        this.blogger_is_super = (blogger.role == 'super')
    setBlogRoot: (blog_root)->
      this.blog_root = blog_root
    isBlogger: ->
      !!this.blogger_id
    canEdit: (blogger_id)->
      this.blogger_is_super || (blogger_id  == this.blogger_id)
  }
