FactoryBot.define do
  factory :device do
    md5_hash { SecureRandom.hex.to_s }

  end
end
