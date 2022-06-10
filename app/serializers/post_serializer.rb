class PostSerializer < ActiveModel::Serializer
  # rails usa el serializador para representar enjson el objeto asociado al serializador
  # para tener mas control de como rails serializa nuestros objetos a json
  attributes :id, :title, :content, :published, :author # como auhtor no pertenece al modelo se debe definir

  def author
    user = self.object.user
    {
      name: user.name,
      email: user.email,
      id: user.id
    }
  end
end
