AngularBlogApp.factory "Component", ($resource) ->
  ComponentResource = $resource(blog_root + "components/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Component extends ComponentResource