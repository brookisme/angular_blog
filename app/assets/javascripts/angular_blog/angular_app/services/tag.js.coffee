AngularBlogApp.factory "Tag", ($resource) ->
  TagResource = $resource(blog_root + "tags/:id", {id: "@id"}, {update: {method: "PUT"}})
  class Tag extends TagResource