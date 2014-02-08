AngularBlogApp.factory "Blurb", ($resource) ->
  BlurbResource = $resource(blog_root + "blurbs/:id", {id: "@id"}, {update: {method: "PUT"}})
  class Blurb extends BlurbResource