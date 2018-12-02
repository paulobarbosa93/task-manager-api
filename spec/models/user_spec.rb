require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { expect(subject).to respond_to(:email) }
  it { is_expected.to respond_to(:email) } # testa uma instancia sem usar o factory
  it { expect(subject).to respond_to(:name) }
  it { expect(subject).to respond_to(:password) }
  it { expect(subject).to respond_to(:password_confirmation) }
  it { expect(subject).to be_valid }
end
