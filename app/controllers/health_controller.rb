class HealthController < ApplicationController
  def health
    render json: { api: 'OK' }, status: :ok
  end
end


# curl localhost:3000/health con eso pruebas el endpopitn desde consola
# curl localhost:3000/health | jq es igual pero lo tira en formato json, jq es un lenguaje funcional
