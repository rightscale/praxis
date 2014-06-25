class Instances
  include Praxis::Controller

  implements ApiResources::Instances

  before :validate, actions: [:index]  do |controller|
    p [:before, :validate, :params_and_headers, controller.request.action.name]
  end

  # before :response do
  #   puts "before response"
  # end  

  before actions: [:show] do
    #puts "before action"
  end
  
  # before :validate do
  #   puts "before validate"
  # end
  
  # after :response do
  #   puts "after response"
  # end  

  # after do
  #   puts "after action"
  # end
  
  # after :validate do
  #   puts "after validate"
  # end

  def index(**params)
    response.headers['Content-Type'] = 'application/json'
    JSON.generate(params)
  end

  def show(cloud_id:, id:, junk:, **other_params)
    payload = request.payload
    response.body = {cloud_id: cloud_id, id: id, junk: junk, other_params: other_params, payload: payload.dump}
    response.headers['Content-Type'] = 'application/json'
    response
  end

end
