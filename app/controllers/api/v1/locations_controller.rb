class Api::V1::LocationsController < Api::ApiController

  def create
    if Location.create_route(location_params)
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 422
    end
  end

  def route
    route = RouteSearch.new(params["map"], params["from"], params["to"], params["autonomy"], params["gas_price"])
    if route.search
      render json: {price: route.route_price, path: route.order}
    else
      render :nothing => true, :status => 404
    end
  end

  private
  def location_params
    params.require(:locations).permit(:to, :from, :distance, :map)
  end

end
