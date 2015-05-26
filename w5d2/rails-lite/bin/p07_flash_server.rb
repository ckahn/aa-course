require 'webrick'
require_relative '../lib/phase7/controller_base'
require_relative '../lib/phase7/flash'
require_relative '../lib/phase6/router'

require 'byebug'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html

class PizzasController < Phase6::ControllerBase
  def index
    render_content("This shouldn't stick around", "text/text")
    redirect_to("/pizzas/1/")
  end

  def show
    render_content(params[:id], "text/text")
  end
end

router = Phase6::Router.new
router.draw do
  get Regexp.new("^/pizzas$"), PizzasController, :index
  get Regexp.new("^/pizzas/(?<id>\\d+)/$"), PizzasController, :show
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  route = router.run(req, res)
end

trap('INT') { server.shutdown }
server.start
