class Api::V1::LocationsController < Api::ApiController

  api :POST, '/v1/locations', 'Cria uma localização em um mapa'
  param :locations, Hash do
    param :distance, Integer, required: true
    param :from, String, required: true
    param :map, String, required: true
    param :to, String, required: true
  end
  error 422, "Campo não validado"
  def create
    route = Route.new(location_params)
    route.save
    respond_with route, location: ""
  end


  api :GET, '/v1/locations/route', 'Busca a melhor rota com o custo de combustivel'
  param :autonomy, Integer, required: true
  param :from, String, required: true
  param :gas_price, :number, required: true
  param :map, String, required: true
  param :to, String, required: true
  error 404, "Busca não encontrou rota"
  error 422, "Campo não validado"
  def route
    route = RouteSearch.new(location_search_params)
    if route.valid?
      if route.search
        render json: {price: route.route_price, path: route.order}
      else
        render :nothing => true, :status => 404
      end
    else
      render json: {errors: route.errors}, :status => 422
    end
  end

  private
  def location_params
    params.require(:locations).permit(:to, :from, :distance, :map)
  end

  def location_search_params
    params.permit(:to, :from, :distance, :map, :autonomy, :gas_price)
  end

end
