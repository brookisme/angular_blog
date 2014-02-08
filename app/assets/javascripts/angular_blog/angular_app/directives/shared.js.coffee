AngularBlogApp.directive "abPartial", ->
  restrict: "AE"
  transclude: true
  template: (el,attrs)->
    if !!attrs.url
      path = blog_root+'templates/'+attrs.url+'.html'
    if !!path
      '<div ng_include="\''+path+'\'"></div>'


AngularBlogApp.directive "abLinkWrap", ($compile)->
  # functions
  wrapper = (value)->
    if !!value
      "<a href='"+value+"'></a>"
    else
      "<span></span>"

  linker = (scope,el,attrs) -> 
    el.wrap(wrapper(attrs.href))
    $compile(el.contents())(scope)

  # directive
  restrict: "AE"
  scope: {
    href: "@"
  }
  link: linker

AngularBlogApp.directive "abConfirm", ->
    link: (scope, el, attrs)->
      msg = attrs.confirm || "Are you sure?"
      el.bind 'click', ->
        scope.$eval(attrs.action) if window.confirm(msg)



    #         %div{ ng_if:"component.type=='header'", partial: true, url: "headers/header", ng_init: "header=component.postable" }
    # %div{ ng_if:"component.type=='blurb'", partial: true, url: "blurbs/blurb", ng_init: "blurb=component.postable" }