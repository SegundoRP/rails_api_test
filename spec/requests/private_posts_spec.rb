require 'rails_helper'

RSpec.describe "Posts with authentication", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:user_post) { create(:post, user_id: user.id) }
  let!(:other_user_post) { create(:post, user_id: other_user.id, published: true) }
  let!(:other_user_post_draft) { create(:post, user_id: other_user.id, published: false) }
  # Authorization: Bearer xxxxx este es el estandar del hheader en request http con token autenticacion
  let!(:auth_headers) { { 'Authorization' => "Bearer #{user.auth_token}" } }
  let!(:other_auth_headers) { { 'Authorization' => "Bearer #{other_user.auth_token}" } }
  # Todo esto son datos de prueba que se necesita y se podran utilizar en las pruebas
  let!(:create_params) { { "title" => "title", "content" => "content", "published" => true }}

  describe "GET /posts/{id}" do
    context 'with valid auth' do
      context "when requisting other's author post" do
        context 'when post is public' do
          before { get "/posts/#{other_user_post.id}", headers: auth_headers }
          # antes se hace la peticion del post

          context 'payload' do
            subject { payload }
            # ese es el sujeto de pruebas
            it { is_expected.to include(:id) }
          end

          context 'response' do
            subject { response }
            it { is_expected.to have_http_status(:ok) }
          end
        end

        context 'when post is draft' do
          before { get "/posts/#{other_user_post_draft.id}", headers: auth_headers }
          # antes se hace la peticion del post

          context 'payload' do
            subject { payload }
            # ese es el sujeto de pruebas
            it { is_expected.to include(:error) }
          end

          context 'response' do
            subject { response }
            it { is_expected.to have_http_status(:not_found) }
          end
        end
      end

      context "when requisting user's post" do

      end
    end
  end

  describe "POST /posts" do
    # con auth -> crear
    context 'with valid auth' do
      before { post "/posts/#{other_user_post_draft.id}", headers: auth_headers }
      # antes se hace la peticion del post

      context 'payload' do
        subject { payload }
        # ese es el sujeto de pruebas
        it { is_expected.to include(:error) }
      end

      context 'response' do
        subject { response }
        it { is_expected.to have_http_status(:not_found) }
      end

    end
    #  sin auth -> !crear -> 401
  end

  describe "PUT /posts" do
  end

  private

  def payload
    JSON.parse(response.body).with_indifferent_access # ese indifferent es un meotdo de hashes hace que accedamos a hashes ya sea como simbolo o string [:id] o ["id"]
  end
end
