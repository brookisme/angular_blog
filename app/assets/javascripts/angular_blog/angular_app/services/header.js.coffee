AngularBlogApp.factory "Header", ($resource) ->
  HeaderResource = $resource(blog_root + "headers/:id", {id: "@id"}, {update: {method: "PUT"}})
  class Header extends HeaderResource