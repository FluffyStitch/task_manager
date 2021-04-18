# frozen_string_literal: true

RSpec.describe Project, type: :model do
  it { is_expected.to have_db_column(:name) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:tasks) }
  it { is_expected.to have_db_index(:user_id) }
end
