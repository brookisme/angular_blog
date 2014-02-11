AngularBlogApp.factory "Blurb", ($resource) ->
  BlurbResource = $resource("blurbs/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Blurb extends BlurbResource