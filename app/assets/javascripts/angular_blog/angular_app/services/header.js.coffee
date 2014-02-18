AngularBlogApp.factory "Header", ($resource) ->
  HeaderResource = $resource("/blog/headers/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Header extends HeaderResource