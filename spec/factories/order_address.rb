Faker::Config.locale = 'ja'

FactoryBot.define do
  factory :order_address do
    postal_code   { Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { Faker::Address.city }
    block         { Faker::Address.street_address }
    building      { Faker::Address.secondary_address }
    phone         { ['080', '090'].sample + Faker::Number.number(digits: 8).to_s }
    token         { Faker::Alphanumeric.alphanumeric(number: 30) }
  end
end
