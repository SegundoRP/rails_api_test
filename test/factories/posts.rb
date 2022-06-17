FactoryBot.use_parent_strategy = false # Esto es para que al crear post cree tmb un user
FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    published {
      r = rand(0..1)
      r.zero?
    }
    user
  end

  factory :published_post, class: 'Post' do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    published { true }
    user
  end
end
