AngularBlogApp.directive "abPostPreview", ->
  restrict: "AE"
  transclude: true
  template: "<span ng-bind-html='preview_string'></span><div><a ng-click='ctrl.togglePreview($index)'>toggle</a></div>"
  link: (scope,el,attrs)->
    max = 300
    post = JSON.parse(attrs.abPostPreview)
    scope.preview_string = "<span class='preview_subject'>"+post.subject+"</span>"
    for component in post.components
      if !!component.postable
        if (component.type == 'Header' || component.type == 'Blurb')
          if !!component.postable.content
            scope.preview_string += component.postable.content.substring(0,max)
            if component.postable.content.length > max
              scope.preview_string +="..."
            scope.preview_string +=" &nbsp; "
    scope.preview_string.substring(0,800)