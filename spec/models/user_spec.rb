# frozen_string_literal: true

RSpec.describe User, type: :model do
  it { is_expected.to have_db_column(:email) }
  it { is_expected.to have_db_column(:encrypted_password) }
  it { is_expected.to have_db_index(:email) }
end
