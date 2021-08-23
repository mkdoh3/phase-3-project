class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    #GET /tasks (index action)
    if req.path.match(/tasks/) && req.get?
      tasks = Task.all
      return [200, { 'Content-Type' => 'application/json' }, [ tasks.to_json ]]
    #POST /task (create action)
    elsif req.path.match(/tasks/) && req.post?
      data = JSON.parse req.body.read
      task = Task.create(data)
      return [200, { 'Content-Type' => 'application/json' }, [ task.to_json ]]
    #DELETE /task (destroy action)
    elsif req.delete?
      id = req.path_info.split('/tasks/').last
      task = Task.find(id)
      task.delete
      return [200, { 'Content-Type' => 'application/json' }, [ {message: 'Task deleted'}.to_json ]]
    else
      resp.write "Path Not Found"

    end

    resp.finish
  end

end
