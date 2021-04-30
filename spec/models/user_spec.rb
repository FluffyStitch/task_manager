# frozen_string_literal: true

RSpec.describe User, type: :model do
  it { is_expected.to have_db_column(:email) }
  it { is_expected.to have_db_column(:encrypted_password) }
  it { is_expected.to have_db_index(:email) }
  it { is_expected.to have_many(:projects) }
  it { is_expected.to have_many(:tasks) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
end
