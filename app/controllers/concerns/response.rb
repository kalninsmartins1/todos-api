# Helper module for api controllers to easily respond with json
module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
