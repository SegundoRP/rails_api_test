module Secured
  def authenticate_user
  # Bearer xxxxx
    token_regex = /^Bearer (\w+)$/
    # leer header de auth
    headers = request.headers
    # verificar que sea valido
    if headers['Authorization'].present? && headers['Authorization'].match(token_regex)
      token = headers['Authorization'].match(token_regex)[1]
      # debemos verificar token corresponda a un user
      # truthy falsy, si asigna un valor es truthy si no asigna es falsy
      if(Current.user = User.find_by_auth_token(token)) # el find_by_... es un Dynamic Finders
        return
      end
    end

    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end

# inicialmente este metodo authenticate estaba en el private de post controller pero es buena practica que este aqui
# ya que los concerns son modulos donde pondremos metodos que podran ser reutilizados por varios controllers
# tambien hay concerns en modelos es lo mismo pero para modelos
# la manera de usarlos es con el include en el controller
