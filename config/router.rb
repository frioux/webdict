# Merb::Router is the request routing mapper for the merb framework.
#
# You can route a specific URL to a controller / action pair:
#
#   r.match("/contact").
#     to(:controller => "info", :action => "contact")
#
# You can define placeholder parts of the url with the :symbol notation. These
# placeholders will be available in the params hash of your controllers. For example:
#
#   r.match("/books/:book_id/:action").
#     to(:controller => "books")
#
# Or, use placeholders in the "to" results for more complicated routing, e.g.:
#
#   r.match("/admin/:module/:controller/:action/:id").
#     to(:controller => ":module/:controller")
#
# You can also use regular expressions, deferred routes, and many other options.
# See merb/specs/merb/router.rb for a fairly complete usage sample.

Merb.logger.info("Compiling routes...")
Merb::Router.prepare do |r|
  # RESTful routes
  r.resources :words

  r.match('/import').
    to(:controller => 'words', :action =>'import').name(:import_words)
  r.match('/find').
    to(:controller => 'words', :action =>'find').name(:find_word)
  r.match('/find_speed/:word').
    to(:controller => 'words', :action =>'speed_find').name(:speed_find)
  r.match('/find_eng/:word').
    to(:controller => 'words', :action =>'eng_find').name(:eng_find)
  r.match('/search_eng/:word').
    to(:controller => 'words', :action =>'eng_search').name(:eng_search)
  r.match('/search_speed/:word').
    to(:controller => 'words', :action =>'speed_search').name(:speed_search)
  # This is the default route for /:controller/:action/:id
  # This is fine for most cases.  If you're heavily using resource-based
  # routes, you may want to comment/remove this line to prevent
  # clients from calling your create or destroy actions with a GET
  r.default_routes

  # Change this for your home page to be available at /
  r.match('/').to(:controller => 'words', :action =>'index').name(:index)
end
