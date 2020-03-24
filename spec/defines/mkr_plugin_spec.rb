require 'spec_helper'

describe 'mackerel_agent::mkr_plugin' do
  let(:title) { 'mackerel-plugin-sample' }
  let(:pre_condition) do <<-EOS
    class { mackerel_agent::install:
      use_mkr => true,
    }
  EOS
  end

  context 'on RedHat has been supported' do
    it { should compile }
  end

  context 'on Debian has been supported' do
    let(:facts) do
      {
        :osfamily => 'Debian',
        :operatingsystem => 'Debian',
        :operatingsystemmajrelease => '9',
        :os => {
          'name' => 'Debian',
          'release' => {
            'full' => '9',
            'major' => '9'
          }
        }
      }
    end
    it { should compile }
  end
end
