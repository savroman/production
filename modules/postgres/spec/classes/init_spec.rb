require 'spec_helper'
describe 'postgres' do
  context 'with default values for all parameters' do
    it { should contain_class('postgres') }
  end
end
