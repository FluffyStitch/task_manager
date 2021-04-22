# frozen_string_literal: true

RSpec.describe TaskForm, type: :form do
  subject { described_class.new(Task.new) }

  let(:invalid_deadline) { FFaker::AnimalUS.common_name }

  it { is_expected.to validate_presence_of(:text) }
  it { is_expected.not_to allow_value(invalid_deadline).for(:deadline) }
end
