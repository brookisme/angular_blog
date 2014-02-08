AngularBlogApp.directive "partial", ->
  restrict: "AE"
  transclude: true
  template: (el,attrs)->
    '<div ng_include="\''+blog_root+'templates/'+attrs.url+'.html\'"></div>'

AngularBlogApp.directive "confirm", ->
    link: (scope, el, attrs)->
      msg = attrs.confirm || "Are you sure?"
      el.bind 'click', ->
        scope.$eval(attrs.action) if window.confirm(msg)