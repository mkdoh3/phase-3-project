class Application

  def call(env)
    resp = Rack::Response.new
    @req = Rack::Request.new(env)


    #GET /tasks (index action)
  if @req.path.match(/tasks/) && @req.get?
      tasks = Task.all
      tasks_with_category = tasks.map do |task|
        {id: task.id, text: task.text, category: task.category.name }
      end
      return [200, { 'Content-Type' => 'application/json' }, [ tasks_with_category.to_json ]]

    # GET /category/:id (show action)
  elsif @req.path.match(/categories/) && params_id && @req.get?
    category = Category.find_by_id(params_id)
    category_and_tasks = {id: category.id, name: category.name, tasks: category.tasks}
    return [200, { 'Content-Type' => 'application/json' }, [ category_and_tasks.to_json ]]

  elsif @req.path.match(/categories/) && @req.get?
    categories = Category.all
    return [200, { 'Content-Type' => 'application/json' }, [ categories.to_json ]]

    #POST /task (create action)
  elsif @req.path.match(/tasks/) && @req.post?
      data = JSON.parse @req.body.read
      puts data
      task = Task.create(data)
      return [200, { 'Content-Type' => 'application/json' }, [ task.to_json ]]
    #DELETE /task (destroy action)
  elsif @req.delete?
      id = @req.path_info.split('/tasks/').last
      task = Task.find(id)
      task.delete
      return [200, { 'Content-Type' => 'application/json' }, [ {message: 'Task deleted'}.to_json ]]
    else
      resp.write "Path Not Found"

    end

    resp.finish
  end

  private

  def params_id
    @req.path_info[/\d+/]
  end


end
