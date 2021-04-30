# frozen_string_literal: true

RSpec.describe ProjectForm, type: :form do
  subject { described_class.new(Project.new) }

  it { is_expected.to validate_presence_of(:name) }
end
