# frozen_string_literal: true

RSpec.describe Task, type: :model do
  it { is_expected.to have_db_column(:text) }
  it { is_expected.to have_db_column(:deadline) }
  it { is_expected.to have_db_column(:position) }
  it { is_expected.to have_db_column(:completed) }
  it { is_expected.to belong_to(:project) }
end
