AngularBlogApp.factory "Component", ($resource) ->
  ComponentResource = $resource("/blog/components/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Component extends ComponentResource