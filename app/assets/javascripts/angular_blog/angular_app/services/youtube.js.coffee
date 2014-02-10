AngularBlogApp.factory "Youtube", ($window) ->
  # settings
  initiated = false
  youtubeReady = false
  width = 640
  height = 360

  currentVideos = -> 
    [].slice.call(document.getElementsByClassName('youtube-container'), 0);

  # functions
  youtubeReady = ->
    youtubeReady = true
    setVideo video for video in currentVideos()

  setVideo = (video)->
    if !video.hasAttribute('data-video-initalized')
      video_identifier = video.getAttribute('data-video-identifier')
      if (!!video_identifier)
        player = new YT.Player('player_'+video_identifier, {
          width: video.getAttribute('data-width') || width,
          height: video.getAttribute('data-height') || height,
          videoId: video_identifier
        })
        video.setAttribute('data-video-initalized',true)

  # factory object
  init: (video_identifier)->
    if !initiated
      initiated = true
      tag = document.createElement('script')
      tag.src = "//www.youtube.com/iframe_api"
      first_tag = document.getElementsByTagName('script')[0]
      first_tag.parentNode.insertBefore(tag, first_tag)
      $window.onYouTubeIframeAPIReady = youtubeReady
    else if youtubeReady
      video = document.getElementById("player_" + video_identifier)
      setVideo(video_identifier) if !!video
