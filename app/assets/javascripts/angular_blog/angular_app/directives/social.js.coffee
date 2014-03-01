#
# ab_facebook
#
AngularBlogApp.directive "abFacebook", ->
  fb_ap_id = '1468271903391665'
  fb_vars = '&amp;width&amp;layout=button&amp;action=like&amp;show_faces=false&amp;share=true&amp;height=35&amp;appId='
  blog_root = 'http%3A%2F%2Flv.ngrok.com%2F'
  fb_div = (link) ->
    '<div 
    class="fb-like" 
      data-href="http://lv.ngrok.com/'+link+'" 
      data-layout="button" 
      data-action="like" 
      data-show-faces="false" 
      data-share="true">
    </div>'

  fb_iframe = (encoded_link) ->
    '<iframe 
      src="//www.facebook.com/plugins/like.php?href='+blog_root+encoded_link+fb_vars+fb_ap_id+'"
      scrolling="no" 
      frameborder="0" 
      style="
        border:none; 
        overflow:hidden;
        height:35px;
      " 
      allowTransparency="true">
    </iframe>'

  # return
  restrict: "AE"
  scope: {
    encodedLink: "@"
  }
  link: (scope,el,attrs) ->
    go_fb = ->
      el.html(fb_iframe(attrs.encodedLink))

    setTimeout(go_fb,1000)

#
# ab_twitter
#
AngularBlogApp.directive "abTwitter", ->
  twitter_base_url = 'https://platform.twitter.com/widgets/tweet_button.html?'
  twitter_vars = 'via=laborvoices&amp;count=none&amp;' 
  blog_root = 'http%3A%2F%2Flv.ngrok.com%2F'
  twitter_iframe = (encoded_link,endcoded_title) ->
    '<iframe 
      allowtransparency="true" 
      frameborder="0" 
      scrolling="no"
      style="width:130px; height:20px;"
      src="'+twitter_base_url+twitter_vars+'text='+endcoded_title+'&amp;url='+blog_root+encoded_link+'"
      >
    </iframe>'

  # return
  restrict: "AE"
  scope: {
    encodedLink: "@",
    encodedSubject: "@"
  }
  link: (scope,el,attrs) ->
    el.html(twitter_iframe(attrs.encodedLink,attrs.encodedSubject))

#
# ab_linkedin
#

# AngularBlogApp.factory "IN", ($window) ->
#   $window.IN or {}

# AngularBlogApp.directive "inAuth", (IN, $timeout) ->
#   scope:
#     callback: "=inAuth"

#   link: (scope, element, attrs) ->
    
#     # bind click event to authorization dialog
#     element.bind "click", ->
#       IN.UI.Authorize().place()
    
#     # respond to auth - trigger callback with profile object
#     IN.Event.onOnce IN, "auth", ->
#       IN.API.Profile("me").result((response) ->
#         profile = response.values[0]
#         scope.$apply (self) ->
#           (self.callback or angular.noop) profile

#       ).error (e) -> alert "woooooooaaah something went terribly wrong!"



# AngularBlogApp.directive "abLinkedin",(LinkdedInManager)->
#   # return
#   restrict: "AE"
#   scope: {
#     link: "@",
#   }
#   link: (scope,el,attrs) ->
#     el.html(LinkdedInManager.script_tag(attrs.link))
#     LinkdedInManager.object_added()


AngularBlogApp.directive "abAddthis",(AddthisManager)->
  # return
  restrict: "AE"
  scope: {
    link: "@",
    title: "@"
  }
  link: (scope,el,attrs) ->
    el.html(AddthisManager.tags(attrs.link,attrs.title))
    AddthisManager.object_added()

