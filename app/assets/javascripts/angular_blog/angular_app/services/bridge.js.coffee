AngularBlogApp.factory "DataBridge", ->
  bridge: {
    edit_mode: false
    toggleEditMode: ->
      this.edit_mode = !this.edit_mode
  }
