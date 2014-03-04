AngularBlogApp.factory "AddthisManager", ->

  init: (blog_root,number_of_objects) ->
    this.blog_root = blog_root
    this.number_loaded = 0
    this.number_of_objects = number_of_objects

  object_added: ->
    this.number_loaded++
    if this.number_loaded == this.number_of_objects
      this.load()

  tags: (link,title) ->
    '<div class="addthis_toolbox addthis_default_style" addthis:url="'+this.blog_root+link.substring(1)+'" addthis:title="'+title+'">
      <a class="addthis_button_twitter"></a>
      <a class="addthis_button_linkedin"></a>
      <a class="addthis_button_facebook"></a>
      <a class="addthis_button_email"></a>
      <a class="addthis_button_compact"></a>
    </div>'

  load: ->
    addthis_script_loader = (d, config_id, id) ->
      config_tag = d.getElementById(config_id);
      if !d.getElementById(id)
        js = d.createElement('script')
        js.id = id
        js.type = "text/javascript"
        js.lang = "en_US"
        js.src = "//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5310c4e55c03540c"
        config_tag.parentNode.insertBefore(js, config_tag)
    addthis_script_loader(document, 'add_this_config', 'addthis_script_loader')