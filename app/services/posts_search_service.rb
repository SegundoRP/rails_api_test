class PostsSearchService
  def self.search(curr_posts, query)
    posts_id = Rails.cache.fetch("posts_search/#{query}", expires_in: 1.hours) do
      curr_posts.where("title like '%#{query}%'").map(&:id)
    end

    curr_posts.where(id: posts_id)
  end
end

# bases dedatos sql no estan optimizadas para hacer busquedas en texto, pueden llegar a ser muy lentas
# para acelerar a busqueda usaremos caching
# primero se busca por texto luego se asigna los ids y apartir de segunda bsuqeda sera mas rapido ya que busca con ids

# por defecto el caching no esta activado usar en consola " rails dev:cache" para activarlo
# y en config/environments/development.rb  config.action_controller.perform_caching = true
