AngularBlogApp.factory "Header", ($resource) ->
  HeaderResource = $resource("headers/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  class Header extends HeaderResource