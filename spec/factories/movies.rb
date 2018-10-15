FactoryBot.define do
  factory :movie do
    title {Faker::Name.name_with_middle}
    release_date {Faker::Date.between(15.years.ago, Date.today)}
    duration {Faker::Number.number(3)}
    loan_price {Faker::Number.decimal(2, 2)}
    country {'usa'}
    classification {'G'}
  end
end