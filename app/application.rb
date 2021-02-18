class Application
  @@items = [Item.new("Figs",3.42),Item.new("Pears",0.99)]

  def call(env)
    res = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path == "/"
      res.write "index page"
    elsif req.path.match(/^\/items/)
      item = req.path.split("/items/").last
      items = @@items.map {|i| i.name}
      if item = @@items.find {|i| i.name == item}
        res.write item.price
      # if items.include?(item)
      #   res.write @@items.find {|i| i.name == item}.price
      else
        res.status = 400
        res.write "Item not found"
      end
    else
      res.status = 404
      res.write "Route not found"
    end

    res.finish
  end
end