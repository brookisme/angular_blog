AngularBlogApp.factory "Tag", ($resource) ->
  TagResource = $resource("tags/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Tag extends TagResource