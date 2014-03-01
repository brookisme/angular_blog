#
# ab_partial:
#   - Load templates from rails app/views/engine_name/angularjs
#
AngularBlogApp.directive "abPartial", ->
  restrict: "AE"
  transclude: true
  template: (el,attrs)->
    if !!attrs.url
      path = '/blog/templates/'+attrs.url+'.html'
    if !!path
      '<div ng_include="\''+path+'\'"></div>'
    else
      '<span class="ab-load-error"></span>'

#
# ab_link_wrapper:
#   - wrap object in link if link exists
#
AngularBlogApp.directive "abLinkWrap", ->
  # functions
  wrapper = (value)->
    if !!value
      "<a href='"+value+"'></a>"
    else
      "<span></span>"

  linker = (scope,el,attrs) -> 
    el.wrap(wrapper(attrs.href))

  # directive
  restrict: "AE"
  scope: {
    href: "@"
  }
  link: linker

#
# ab_confirm:
#   - confirmation dialog
#
AngularBlogApp.directive "abConfirm", ->
    link: (scope, el, attrs)->
      msg = attrs.abConfirm || "Are you sure you want to do that?"
      el.bind 'click', ->
        scope.$eval(attrs.action) if window.confirm(msg)


#
# ab_vimeo:
#  - vimeo universal player
#
AngularBlogApp.directive "abVimeo", ->
  # constants
  base = "http://player.vimeo.com/video/"
  vars = "?portrait=0&amp;color=e13237"
  attributes = "frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen"
  default_width = 640
  default_height = 360

  # functions
  template = (src,width,height)->
    if !!src
      "<iframe src='"+src+"' width='"+(width || default_width)+"'' height='"+(height || default_height)+"'' "+attributes+"></iframe>"
    else
      "<span class='ab-loading'>loading video...</span>"

  video_src = (identifier)->
    base + identifier + vars

  linker = (scope,el,attrs) -> 
    el.html(template(video_src(attrs.identifier),attrs.width,attrs.height))

  # directive
  restrict: "AE"
  scope: {
    identifier: "@",
    width: "@",
    height: "@"
  }
  link: linker




